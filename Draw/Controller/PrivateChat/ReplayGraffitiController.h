//
//  ReplayGraffitiController.h
//  Draw
//
//  Created by haodong on 12-6-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PPViewController.h"

@interface ReplayGraffitiController : PPViewController
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

- (id)initWithDrawActionList:(NSArray *)drawActionList;

@end
