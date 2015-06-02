#import "APManager.h"
#import "route.h"
#import <sys/sysctl.h>
#import <sys/socket.h>
#import <netdb.h>
#import <AssertMacros.h>
#import <CFNetwork/CFNetwork.h>
#import <netinet/in.h>
#import <errno.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>

#define ROUNDUP(a) \
((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))

@implementation APManager

+ (APManager*)sharedInstance{
    static APManager *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [NSAllocateObject([self class], 0, NULL) init];
    });
    return sharedClient;
}

- (NSString *)displayAddressForAddress:(NSData *)address {
    int         err;
    NSString *  result;
    char        hostStr[NI_MAXHOST];
    
    result = nil;
    
    if (address != nil) {
        err = getnameinfo([address bytes], (socklen_t) [address length], hostStr, sizeof(hostStr), NULL, 0, NI_DGRAM);
        if (err == 0) {
            result = [NSString stringWithCString:hostStr encoding:NSASCIIStringEncoding];
            assert(result != nil);
        }
    }
    
    return result;
}

- (NSString *)getIPAddress {
    return [[self getIfaddrs] objectForKey:@"address"];
}

- (NSString *)getNetmask {
    return [[self getIfaddrs] objectForKey:@"netmask"];
}

- (NSString *)getDstaddr {
    return [[self getIfaddrs] objectForKey:@"dstaddr"];
}

- (NSString *)getBroadcast {
    return [[self getIfaddrs] objectForKey:@"dstaddr"];
}

- (NSDictionary *)getIfaddrs {
    NSString *ifma_name;
    NSString *ifma_addr;
    NSString *ifma_lladdr;

    struct ifmaddrs *ifmaddrss = NULL;
    struct ifmaddrs *ifmaddrss_temp = NULL;
    int ifmaSuccess = 0;
    ifmaSuccess = getifmaddrs(&ifmaddrss);
    if (ifmaSuccess) {
        ifmaddrss_temp = ifmaddrss;
        while (ifmaddrss_temp) {
//            if([[NSString stringWithUTF8String:ifmaddrss_temp->ifma_name] isEqualToString:@"en0"]) {
                ifma_name = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)ifmaddrss_temp->ifma_name)->sin_addr)];
                ifma_addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)ifmaddrss_temp->ifma_addr)->sin_addr)];
                ifma_lladdr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)ifmaddrss_temp->ifma_lladdr)->sin_addr)];
//                dstaddr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)ifmaddrss_temp->ifa_dstaddr)->sin_addr)];
//            }

            ifmaddrss_temp = ifmaddrss_temp->ifma_next;
        }
    }

    NSString *address = @"";
    NSString *netmask = @"";
    NSString *dstaddr = @"";
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String for IP
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                    dstaddr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free/release memory
    freeifaddrs(interfaces);
    return [NSDictionary dictionaryWithObjectsAndKeys:address, @"address", netmask, @"netmask", dstaddr, @"dstaddr", nil];
}

- (NSString*)ssidForConnectedNetwork{
    NSArray *interfaces = (__bridge NSArray*)CNCopySupportedInterfaces();
    NSDictionary *info = nil;
    for (NSString *ifname in interfaces) {
        info = (__bridge NSDictionary*)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
        if (info && [info count]) {
            break;
        }
        info = nil;
    }
        
    NSString *ssid = nil;
    if ( info ){
        ssid = [info objectForKey:@"SSID"];//CFDictionaryGetValue((CFDictionaryRef)info, kCNNetworkInfoKeySSID);
    }
    return ssid ? ssid : @"";
}

- (NSString *)getGatewayAddress {
    /* net.route.0.inet.flags.gateway */
    int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET,
        NET_RT_FLAGS, RTF_GATEWAY};
    size_t l;
    char * buf, * p;
    struct rt_msghdr * rt;
    struct sockaddr * sa;
    struct sockaddr * sa_tab[RTAX_MAX];
    int i;
    char *address = NULL;
    
    NSString *routerAddrses;
    
    if(sysctl(mib, sizeof(mib)/sizeof(int), 0, &l, 0, 0) < 0) {
        return nil;
    }
    if(l<=0)
        return nil;
    
    buf = malloc(l);
    if(sysctl(mib, sizeof(mib)/sizeof(int), buf, &l, 0, 0) < 0) {
        return nil;
    }
    
    for(p=buf; p<buf+l; p+=rt->rtm_msglen) {
        rt = (struct rt_msghdr *)p;
        sa = (struct sockaddr *)(rt + 1);
        for(i=0; i<RTAX_MAX; i++) {
            if(rt->rtm_addrs & (1 << i)) {
                sa_tab[i] = sa;
                sa = (struct sockaddr *)((char *)sa + ROUNDUP(sa->sa_len));
            } else {
                sa_tab[i] = NULL;
            }
        }
        
        if( ((rt->rtm_addrs & (RTA_DST|RTA_GATEWAY)) == (RTA_DST|RTA_GATEWAY))
           && sa_tab[RTAX_DST]->sa_family == AF_INET
           && sa_tab[RTAX_GATEWAY]->sa_family == AF_INET) {
            
            
            if(((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr.s_addr == 0) {
                address = inet_ntoa(((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr);
                break;
            }
        }
    }
    free(buf);
    
    routerAddrses = [[NSString alloc] initWithFormat:@"%s",address];
    return routerAddrses;
}

@end
