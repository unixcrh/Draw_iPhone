//
//  MusicSettingCell.m
//  Draw
//
//  Created by gckj on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicSettingCell.h"
#import "MusicItemManager.h"
#import "LocaleUtils.h"
#import "AudioManager.h"

@implementation MusicSettingCell

@synthesize musicNameLabel;
@synthesize downloadProgress;
@synthesize musicItem = _musicItem;

+ (MusicSettingCell*) createCell:(id)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MusicSettingCell" owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <MusicSettingCell> but cannot find cell object from Nib");
        return nil;
    }
    
    MusicSettingCell* cell = (MusicSettingCell*)[topLevelObjects objectAtIndex:0];
    cell.delegate = delegate;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;

}

- (void)setCellInfoWithItem:(MusicItem*)item indexPath:(NSIndexPath*)indexPath
{
    _musicItem = item;
    
    if ([item.fileName isEqualToString:NSLS(@"kDefaultMusic")]) {
        self.musicNameLabel.text = NSLS(@"kDefaultMusic");
    }else {
        NSArray* nameArray = [item.fileName componentsSeparatedByString:@"."];
        if ([nameArray count] == 2) {
            NSString *tempName = [nameArray objectAtIndex:0];
            nameArray = [tempName componentsSeparatedByString:@"_"];
            if ([nameArray count] == 2) {
                self.musicNameLabel.text = [nameArray objectAtIndex:1];
            } 
            else {
                self.musicNameLabel.text = tempName;
            }
        } 
        else {
            self.musicNameLabel.text = item.fileName;
        }
    }
    
    [musicNameLabel setTextColor:[UIColor brownColor]];
    self.downloadProgress.progress = [item.downloadProgress floatValue];
    
    if ([[MusicItemManager defaultManager] isNoneOrDefaultMusic:item]) {
        self.downloadProgress.hidden = YES;
    }
    if (item.downloadProgress.floatValue == 1.0) {
        self.downloadProgress.hidden = YES;
        //rejust the musicNameLabel width
        CGRect frame = self.musicNameLabel.frame;
        frame.size.width = 250;
        self.musicNameLabel.frame = frame;
    }
}

@end
