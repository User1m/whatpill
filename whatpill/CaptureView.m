    //
    //  CaptureView.m
    //  whatpill
    //
    //  Created by Claudius Mbemba on 10/18/14.
    //  Copyright (c) 2014 Claudius Mbemba. All rights reserved.
    //

#import "CaptureView.h"
#import "ButtonView.h"
#import "CamfindApi.h"

@interface CaptureView ()

@end

@implementation CaptureView

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertView * alert = [[[UIAlertView alloc]init] initWithTitle:@"Error"
                                                               message:@"Device has no camera"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles: nil];
        
        [alert show];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    
    
    
}


- (IBAction)selectPhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (IBAction)takePhoto:(id)sender {
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil);
    
        //send image to server
//    NSMutableDictionary * params =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"en_US", @"image_request[locale]", @"http://cdn.medgadget.com/img/tylenol-now.jpg",@"image_request[remote_image_url]", nil];
    
    [[CamfindApi sharedClient]
     withId:@"getToken" optionalStr:nil onCompletion:^(NSDictionary *json) {
             //completion
         if(![json objectForKey:@"error"]){
             
                 //success
             [[[UIAlertView alloc]initWithTitle:@"Success!"
                                        message:@"Your photo was uploaded"
                                       delegate:nil
                              cancelButtonTitle:@"Great!"
                              otherButtonTitles:nil, nil] show];
             
             NSString * q = json[@"token"];
             
             NSLog(@"Token: %@", q);
             
                 //
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 25.0 * NSEC_PER_SEC ); // where 2.0 as a second * nano seconds
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
                 
                     //get item name
                 [[CamfindApi sharedClient]withId:@"getName" optionalStr:q onCompletion:^(NSDictionary *json) {
                     
                     NSString * q = json[@"name"];
                     q = [q stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                     
                     NSLog(@"NAME: %@", q);
                     
                         //query Mike's api
                     [[CamfindApi sharedClient] withId:nil optionalStr:q onCompletion:^(NSDictionary *json) {
                     
                        
                     }];
                     
                     
                 }];
                 
                 
             });
             
             
         }else{
             
             NSLog(@"Json data: %@", json);
                 //error, check for expired session and if so - authroize the user
             NSString * err = [json objectForKey:@"error"];
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:err delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
             
             [alert show];
         }
         
         
     }];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
