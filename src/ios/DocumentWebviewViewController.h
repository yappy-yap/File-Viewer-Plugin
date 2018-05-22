//
//  DocumentWebviewViewController.h
//  OutSystems
//
//  Created by Vitor Oliveira on 01/08/16.
//
//

#import <UIKit/UIKit.h>

@interface DocumentWebviewViewController : UIViewController
{
    UIWebView *webView;
}
@property (retain, nonatomic) UIWebView *webView;
@property (retain, nonatomic) UIButton *buttonCloseView;

-(void) loadDocumentWithUrl:(NSString *) urlString;
@end
