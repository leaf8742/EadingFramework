/**
 * @file
 * @author 单宝华
 * @date 2014/03/31
 * @copyright 大连一丁芯智能技术有限公司
 */
#import "UserInformation.h"

/**
 * @class ServiceRemotes
 * @brief 服务器获得的遥控器品牌与型号列表
 * @author 单宝华
 * @date 2014/03/31
 */
@interface ServiceRemotes : NSObject

/// [{@"type":NSNumber, @"brand":NSString, @"model":NSString}]
@property (retain, nonatomic) NSMutableArray *serviceRemotes;

+ (ServiceRemotes *)sharedInstance;

- (NSArray *)remoteTitlesWithType:(kRemoteType)type;

@end
