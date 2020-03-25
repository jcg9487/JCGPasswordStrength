//
//  ViewController.m
//  PasswordStrength
//
//  Created by Edward on 2020/3/24.
//  Copyright © 2020 Edward. All rights reserved.
//

#import "ViewController.h"
#import "PasswordStrengthUtil.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:_pwdTF];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:_pwdTF];
}

#pragma mark -
- (void)textFieldTextDidChangeNotification:(NSNotification *)notification {
    
    UITextField *textField = notification.object;
    NSString *currentText = textField.text;
    
    NSInteger score =  [[PasswordStrengthUtil sharedInstance] passwordStrengthWithPassword:currentText];
    _levelLabel.text = [NSString stringWithFormat:@"得分 %ld",(long)score];
}


@end
