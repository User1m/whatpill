//
//  DetailView.h
//  whatpill
//
//  Created by Claudius Mbemba on 10/19/14.
//  Copyright (c) 2014 Claudius Mbemba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CamfindApi.h"
#import "CaptureView.h"

@interface DetailView : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *detailsInfo;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property(strong, nonatomic) NSDictionary * results;

@end
