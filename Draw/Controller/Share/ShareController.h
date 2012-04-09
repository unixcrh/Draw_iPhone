//
//  ShareController.h
//  Draw
//
//  Created by Orange on 12-3-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "ShareCell.h"
#import "ShowDrawView.h"
#import "CommonDialog.h"

enum{
    
    SHARE_VIA_ALBUM = 0,
    SHARE_VIA_EMAIL,
    SHARE_VIA_SNS    
};


@interface ShareController : PPViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, ShareCellDelegate, ShowDrawViewDelegate, CommonDialogDelegate> {
    NSArray*_paints;
    int _currentSelectedPaint;
    NSMutableArray *_gifImages;
}
@property (retain, nonatomic) IBOutlet UISegmentedControl *paintsFilter;
@property (retain, nonatomic) IBOutlet UITableView *gallery;
@property (retain, nonatomic) NSArray* paints;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)changeGalleryFielter:(id)sender;

@end
