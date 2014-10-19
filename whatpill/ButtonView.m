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
    
    if ([[segue identifier] isEqualToString:@"ShowCam"]) {
        CaptureView * capture = segue.destinationViewController;
    }
        //
    
}

-(BOOL) shouldAutorotate{
    return FALSE;
}


    //- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
    //{
    //        // Return YES for supported orientations
    //    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //}

- (IBAction)launchCapture:(CaptureView *)sender {
    
        //            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@" MainButton" message:@"Button clicked" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //
        //            [alert show];
    
        //            [self performSegueWithIdentifier:@"ShowCam" sender:self];
    
}
@end
