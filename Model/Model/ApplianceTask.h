//
//  ApplianceTask.h
//  com.eading.wireless
//
//  Created by Q on 15/1/15.
//
//

#import <Foundation/Foundation.h>
#import "Common.h"

@interface ApplianceTask : NSObject

@property (strong, nonatomic) NSString *time;
@property (nonatomic) kOperateCommand command;

@end
