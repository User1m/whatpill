//
//  CaptureView.h
//  whatpill
//
//  Created by Claudius Mbemba on 10/18/14.
//  Copyright (c) 2014 Claudius Mbemba. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CaptureView : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSDictionary * data;
@property (strong, nonatomic) UIImagePickerController * picker;
@property (strong, nonatomic) IBOutlet UIButton *goBtn;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UIButton *takeBtn;

@property (strong, nonatomic) NSString * strParam;

- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)goToDetail:(UIButton *)sender;

@end
