//
//  ViewController.m
//  SharedKeychainDemoApp2
//
//  Created by Marcin Iwanicki on 06/04/2016.
//  Copyright © 2016 Marcin Iwanicki. All rights reserved.
//

#import "ViewController.h"
#import "SSKeychain.h"

@interface ViewController ()

@property(nonatomic, weak) IBOutlet UILabel *tokenLabel;

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
    [self refreshTokenLabel];
}

- (void)applicationDidBecomeActiveNotificaton:(NSNotification *)notification {
    [self refreshTokenLabel];
}

- (void)refreshTokenLabel {
    NSString *password = [SSKeychain passwordForService:@"SKDA" account:@"marcin"];
    self.tokenLabel.text = password;
}

@end
