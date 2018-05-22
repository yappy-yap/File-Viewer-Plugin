//
//  DocumentWebviewViewController.m
//  OutSystems
//
//  Created by Vitor Oliveira on 01/08/16.
//
//

#import "DocumentWebviewViewController.h"

@interface DocumentWebviewViewController ()

@end

@implementation DocumentWebviewViewController

@synthesize webView;
@synthesize buttonCloseView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    navbar.barTintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    navbar.translucent = NO;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // set left barButtonItem with custom view
    navbar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //do something like background color, title, etc you self
    [self.view addSubview:navbar];
    
    self.buttonCloseView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonCloseView addTarget:self
               action:@selector(backButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.buttonCloseView setTitle:@"Close View" forState:UIControlStateNormal];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.buttonCloseView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 160.0, 30, 160.0, 40.0);
    } else {
        self.buttonCloseView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 160.0, 10, 160.0, 40.0);
    }
    [self.view addSubview:self.buttonCloseView];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height - 70))];
    } else {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height - 50))];
    }
    [[self.webView scrollView] setContentOffset:CGPointMake(0,500) animated:YES];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.scrollTo(0.0, 50.0)"]];
    
    //Enabling zoom for preview
    self.webView.scalesPageToFit=YES;
    
    //Handle with rotation on iPhoneX
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotated:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void) loadDocumentWithUrl:(NSString *) urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    [self.view addSubview:self.webView];
}

- (void)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rotated:(NSNotification *)notification {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;

       if(orientation == UIInterfaceOrientationPortrait){
            [self.webView setFrame:CGRectMake(0, 70, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height - 70))];
            [self.buttonCloseView setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 160.0, 30, 160.0, 40.0)];
        }
        else if(orientation == UIInterfaceOrientationLandscapeLeft){
            [self.webView setFrame:CGRectMake(0, 50, ([[UIScreen mainScreen] bounds].size.width - 35), ([[UIScreen mainScreen] bounds].size.height - 50))];
            [self.buttonCloseView setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 160.0, 10, 160.0, 40.0)];
        }
        else if(orientation == UIInterfaceOrientationLandscapeRight) {
            [self.webView setFrame:CGRectMake(35, 50, ([[UIScreen mainScreen] bounds].size.width - 35), ([[UIScreen mainScreen] bounds].size.height - 50))];
            [self.buttonCloseView setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 160.0, 10, 160.0, 40.0)];
        }
    }
}

@end
