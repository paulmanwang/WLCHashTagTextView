//
//  ViewController.m
//  WLCHashTagTextViewDemo
//
//  Created by lichunwang on 2017/6/7.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "ViewController.h"
#import "WLCHashTagTextView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet WLCHashTagTextView *textView2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    WLCHashTagTextView *textView1 = [[WLCHashTagTextView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
    textView1.center = CGPointMake(self.view.frame.size.width / 2, 200);
    textView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView1];
    [textView1 becomeFirstResponder];
    
    self.textView2.hashTagColor = [UIColor greenColor];
    self.textView2.text = @"#funny, test test test";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
