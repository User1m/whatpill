    //
    //  ButtonView.m
    //  whatpill
    //
    //  Created by Claudius Mbemba on 10/18/14.
    //  Copyright (c) 2014 Claudius Mbemba. All rights reserved.
    //

#import "CaptureView.h"
#import "ButtonView.h"
#import "CamfindApi.h"
#import <UNIRest.h>

@interface ButtonView ()

@end

@implementation ButtonView

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        //     Get the new view controller using [segue destinationViewController].
        //     Pass the selected object to the new view controller.
    
//            if ([[segue identifier] isEqualToString:@"ShowCam"]) {
//                [[segue destinationViewController] setDelegate:self];
//            }
//    
    
}


- (IBAction)launchCapture:(CaptureView *)sender {
    
        //    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@" MainButton" message:@"Button clicked" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //
        //    [alert show];
    
        //    [self performSegueWithIdentifier:@"ShowCam" sender:sender];
    
//    NSMutableDictionary * params =[NSMutableDictionary dictionaryWithObjectsAndKeys: @"480",@"focus[x]", @"640", @"focus[y]", @"27.912109375", @"image_request[altitude]", @"", @"image_request[image]", @"en", @"image_request[language]", @"35.8714220766008", @"image_request[latitude]", @"en_US", @"image_request[locale]", @"14.3583203002251",@"image_request[longitude]", @"http://upload.wikimedia.org/wikipedia/en/2/2d/Mashape_logo.png",@"image_request[remote_image_url]", nil];

    }
@end
