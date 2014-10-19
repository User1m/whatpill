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
#import "DetailView.h"
#import <QuartzCore/QuartzCore.h>
#import <FlatUIKit.h>
#import "SVProgressHUD.h"


@interface CaptureView ()

@end

@implementation CaptureView

-(BOOL) shouldAutorotate{
    return FALSE;
}


-(void) viewDidAppear:(BOOL)animated{
    
    _picker = [[UIImagePickerController alloc]init];
    _picker.delegate = self;
    _picker.allowsEditing = YES;
    
//    [_takeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _takeBtn.backgroundColor = [UIColor redColor];
    _selectBtn.backgroundColor = [UIColor redColor];
    _goBtn.backgroundColor = [UIColor redColor];
//    [_takeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    if([@"ShowDetail" compare:segue.identifier]==NSOrderedSame){
            //create an instance of the view you're going to then set it as the seque.destinationViewController
        DetailView * detail = segue.destinationViewController;
        
            //shortcut to send a parameter to the prepareSegue method.
        detail.results = self.data;
    }
    
    
}


- (IBAction)selectPhoto:(id)sender {
    
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_picker animated:YES completion:nil];
    
}

- (IBAction)takePhoto:(id)sender {
    
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:_picker animated:YES completion:nil];
}

- (IBAction)goToDetail:(id)sender {
    
        //    [self performSegueWithIdentifier:@"ShowDetail" sender:self];
    
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self takeBtn].hidden = true;
    self.selectBtn.hidden = true;
    
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil);
    
    
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
             
             _strParam = json[@"token"];
             
             NSLog(@"Token: %@", _strParam);
             
         }else{
             
             NSLog(@"Json data: %@", json);
                 //error, check for expired session and if so - authroize the user
             NSString * err = [json objectForKey:@"error"];
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:err delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
             
             [alert show];
         }
         
     }];
    
    
    [SVProgressHUD show];
        //
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 25.0 * NSEC_PER_SEC ); // where 2.0 as a second * nano seconds
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        
            //get item name
        [[CamfindApi sharedClient]withId:@"getName" optionalStr:[self strParam] onCompletion:^(NSDictionary *json) {
            
            NSString * q = json[@"name"];
            NSArray *array = [q componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSLog(@"NAME: %@", array[0]);
            
            [SVProgressHUD dismiss];
            _strParam = array[0];
            
            
            NSLog(@"param1: %@",_strParam);
            
        }];
        
            //query Mike's api
        [[CamfindApi sharedClient] withId:nil optionalStr:_strParam onCompletion:^(NSDictionary *json) {
            
            NSLog(@"param2: %@",_strParam);
            
            self.data = json;
            self.goBtn.hidden = false;
            
                //
                //                                          DetailView *detailVC = [[DetailView alloc] init];
                //                                          [self presentViewController:detailVC animated:YES completion:nil];
                //
        }];
        
    });
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
