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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    //navbar.barTintColor = [UIColor whiteColor];
    navbar.barTintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    navbar.translucent = NO;
   /* UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Flip"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(flipView)];
    
    navbar.topItem.leftBarButtonItem = flipButton; */
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
   // backButton.frame = CGRectMake(0, 0, 40, 22); // custom frame
   // [backButton setImage:[UIImage imageNamed:@"icon_chevron-left_red"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // set left barButtonItem with custom view
    navbar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //do something like background color, title, etc you self
    [self.view addSubview:navbar];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(backButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Close View" forState:UIControlStateNormal];
    button.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 160.0, 10, 160.0, 40.0);
    [self.view addSubview:button];
    
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 50, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height - 50))];
    [[self.webView scrollView] setContentOffset:CGPointMake(0,500) animated:YES];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.scrollTo(0.0, 50.0)"]];
    
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

@end
