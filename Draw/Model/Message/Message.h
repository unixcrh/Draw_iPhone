//
//  Message.h
//  Draw
//
//  Created by haodong qiu on 12年6月8日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * messageId;
@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) NSData * drawData;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * status;

@end
