//
//  PlayerCellTableViewCell.h
//  TEDxOxford
//
//  Created by Ari Aparikyan on 24/09/2014.
//  Copyright (c) 2014 Ari Aparikyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPJSONDataManagerDelegate.h"

@interface NewsCellTableViewCell : UITableViewCell

@property IBOutlet UIImageView *thumbnailImage;
@property IBOutlet UILabel *titleLabel;
@property IBOutlet UILabel *excerptLabel;

@end
