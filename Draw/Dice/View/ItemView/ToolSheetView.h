//
//  ToolSheetView.h
//  Draw
//
//  Created by haodong qiu on 12年7月30日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolSheetViewDelegate <NSObject>

- (void)didSelectTool:(NSInteger)index;

@end


@interface ToolSheetView : UIView

@property (assign, nonatomic) id<ToolSheetViewDelegate> delegate;
@property (retain, nonatomic) UIImageView *backgroundImageView;

- (id)initWithImageNameList:(NSArray *)imageNameList delegate:(id<ToolSheetViewDelegate>)delegate;
- (void)showInButton:(UIButton *)button;

@end