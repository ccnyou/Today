//
//  ViewController.m
//  today
//
//  Created by ervinchen on 16/6/12.
//  Copyright © 2016年 ccnyou. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)set:(id)sender {
    NSString* text = self.textField.text;
    NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.ccnyou.today"];
    [userDefault setObject:text forKey:@"ext"];
    [userDefault synchronize];
    
    UIImageView* imageView;
    [imageView sd_setImageWithURL:nil];
}
@end
