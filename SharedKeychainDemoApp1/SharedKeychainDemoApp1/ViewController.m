//
//  ViewController.m
//  SharedKeychainDemoApp1
//
//  Created by Marcin Iwanicki on 06/04/2016.
//  Copyright © 2016 Marcin Iwanicki. All rights reserved.
//

#import "ViewController.h"
#import "SSKeychain.h"

#define kSharedKeychainDemoApp2URLString @"SharedKeychainDemoApp2://"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet UITextField *tokenTextField;
@property(nonatomic, weak) IBOutlet UILabel *canOpenDemoApp2ValueLabel;

@end

@implementation ViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActiveNotificaton:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshCanOpenDemoApp2ValueLabel];
}

- (IBAction)openDemoApp2:(id)sender {
    [SSKeychain setPassword:self.tokenTextField.text forService:@"SKDA" account:@"marcin"];
    
    NSURL *demoApp2URL = [NSURL URLWithString:kSharedKeychainDemoApp2URLString];
    BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:demoApp2URL];
    if (canOpenURL) {
        [[UIApplication sharedApplication] openURL:demoApp2URL];
    }
}

- (void)applicationDidBecomeActiveNotificaton:(NSNotification *)notification {
    [self refreshCanOpenDemoApp2ValueLabel];
}

- (void)refreshCanOpenDemoApp2ValueLabel {
    NSURL *demoApp2URL = [NSURL URLWithString:kSharedKeychainDemoApp2URLString];
    self.canOpenDemoApp2ValueLabel.text = [[UIApplication sharedApplication] canOpenURL:demoApp2URL] ? @"YES" : @"NO";
}

@end
