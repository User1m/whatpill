    //
    //  DetailView.m
    //  whatpill
    //
    //  Created by Claudius Mbemba on 10/19/14.
    //  Copyright (c) 2014 Claudius Mbemba. All rights reserved.
    //

#import "DetailView.h"

@interface DetailView ()

@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    NSString * uses = self.results[@"drug"][@"uses"];
    NSString * name = self.results[@"drug"][@"name"];
    
    [self.labelTitle setText: name];
    [self.detailsInfo setText: uses];
        //[self.labelTitle setText:self.results[@"name"]];
        //[self.detailsInfo setText:self.results[@"uses"]];
    
    
    
    NSLog(@"Passed: %@", [self results]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

-(BOOL) shouldAutorotate{
    return FALSE;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
