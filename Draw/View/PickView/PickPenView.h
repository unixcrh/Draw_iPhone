//
//  PickPenView.h
//  Draw
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PickView.h"

@interface PickPenView : PickView
{
    NSMutableArray *_penArray;
}
- (void)updatePenViews;
@end
