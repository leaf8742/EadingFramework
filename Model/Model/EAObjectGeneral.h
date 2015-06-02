/**
 * @file
 * @author 单宝华
 * @date 2014-12-2
 */
#import <Foundation/Foundation.h>
#import "Common.h"

/**
 * @protocol EAObjectGeneral
 * @brief 对象协议
 * @author 单宝华
 * @date 2014-12-2
 */
@protocol EAObjectGeneral <NSObject>

/// @brief 标题
@property (strong, nonatomic) NSString *title;

/// @brief 对象类型
@property (assign, nonatomic) kEAObjectType objectType;

/// @brief 子类型
@property (assign, nonatomic) kSubType subType;

/// @brief 电器类型
@property (strong, nonatomic) NSString *electricType;

/// @brief 电器类型code
@property (assign, nonatomic) kElectricType electricTypeCode;

/// @brief 图片
@property (strong, nonatomic) NSString *picture;

/// @brief 绑存图片
@property (readonly, nonatomic) NSString *mementoPicture;

/// @brief 楼层
@property (assign, nonatomic) NSInteger floor;

/// @brief 位置
@property (strong, nonatomic) NSString *place;

/// @brief 唯一标识
@property (strong, nonatomic) NSString *identity;

/// @brief 备注
@property (strong, nonatomic) NSString *remark;

/// @brief 历史记录
@property (strong, nonatomic) NSMutableArray *history;

/// @brief 时间戳
@property (strong, nonatomic) NSString *timestamp;

/// @brief 创建时间
@property (strong, nonatomic) NSDate *creationDate;

/// @brief 品牌
@property (strong, nonatomic) NSString *brand;

/// @brief 产品型号
@property (strong, nonatomic) NSString *model;

/// @brief 根据identity初始化
@optional
- (id)initWithIdentity:(NSString *)identity;

@end

/**
 @synthesize title = _title;
 @synthesize objectType = _objectType;
 @synthesize subType = _subType;
 @synthesize electricType = _electricType;
 @synthesize electricTypeCode = _electricTypeCode;
 @synthesize picture = _picture;
 @synthesize mementoPicture = _mementoPicture;
 @synthesize floor = _floor;
 @synthesize place = _place;
 @synthesize identity = _identity;
 @synthesize remark = _remark;
 @synthesize history = _history;
 @synthesize timestamp = _timestamp;
 @synthesize creationDate = _creationDate;
 @synthesize brand = _brand;
 @synthesize model = _model;
 */
