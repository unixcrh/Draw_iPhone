//
//  ExpressionManager.h
//  Draw
//
//  Created by 小涛 王 on 12-5-9.
//  Copyright (c) 2012年 甘橙软件. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressionManager : NSObject

+ (ExpressionManager *)defaultManager;
- (UIImage *)expressionForKey:(NSString*)key;
- (NSArray *)allKeys;
//- (NSArray *)allValues;

@end
