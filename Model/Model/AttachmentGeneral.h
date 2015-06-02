/**
 * @file
 * @author 单宝华
 * @date 2014-12-3
 */
#import <Foundation/Foundation.h>
#import "Common.h"

/**
 * @protocol AttachmentGeneral
 * @brief 配件协议
 * @author 单宝华
 * @date 2014-12-3
 */
@protocol AttachmentGeneral <NSObject>

/// @brief 配件类型
@property (assign, nonatomic) kAttachmentType type;

/// @brief 唯一标识
@property (strong, nonatomic) NSString *identity;

/// @brief 位置
@property (strong, nonatomic) NSString *place;

/// @brief 楼层
@property (strong, nonatomic) NSString *floor;

/// @brief 历史消息
@property (strong, nonatomic) NSMutableArray *history;

/// @brief 消息个数
@property (assign, nonatomic) NSUInteger historyCount;

/// @brief 工作开关
@property (assign, nonatomic) BOOL workEnabled;

/// @brief 推送开关
@property (assign, nonatomic) BOOL pushEnabled;

/// @brief 启用时间
@property (nonatomic) NSUInteger beginTime;

/// @brief 关闭时间
@property (nonatomic) NSUInteger endTime;

/// @brief 开始推送时间
@property (nonatomic) NSUInteger beginNotifyTime;

/// @brief 结束推送时间
@property (nonatomic) NSUInteger endNotifyTime;

/// @brief 配件相关值
@property (strong, nonatomic) NSValue *value;

/// @brief 根据identity初始化
- (id)initWithIdentity:(NSString *)identity;

@end

/**
 @synthesize type = _type;
 @synthesize identity = _identity;
 @synthesize place = _place;
 @synthesize floor = _floor;
 @synthesize history = _history;
 @synthesize historyCount = _historyCount;
 @synthesize workEnabled = _workEnabled;
 @synthesize pushEnabled = _pushEnabled;
 @synthesize beginTime = _beginTime;
 @synthesize endTime = _endTime;
 @synthesize beginNotifyTime = _beginNotifyTime;
 @synthesize endNotifyTime = _endNotifyTime;
 @synthesize value = _value;
 */
