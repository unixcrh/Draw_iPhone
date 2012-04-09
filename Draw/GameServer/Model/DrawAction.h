//
//  DrawAction.h
//  Draw
//
//  Created by  on 12-3-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Paint;

typedef enum {
    
    DRAW_ACTION_TYPE_DRAW,
    DRAW_ACTION_TYPE_CLEAN
} DRAW_ACTION_TYPE;

@interface DrawAction : NSObject <NSCoding>{
    
}

@property (nonatomic, assign) DRAW_ACTION_TYPE type;
@property (nonatomic, retain) Paint *paint;
- (NSInteger)pointCount;
- (id)initWithType:(DRAW_ACTION_TYPE)aType paint:(Paint*)aPaint;
+ (DrawAction *)actionWithType:(DRAW_ACTION_TYPE)aType paint:(Paint*)aPaint;
+ (BOOL)isDrawActionListBlank:(NSArray *)actionList;
+ (NSArray *)getTheLastActionListWithoutClean:(NSArray *)actionList;
@end
