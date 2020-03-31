//
//  DocumentWebviewViewController.h
//  OutSystems
//
//  Created by Vitor Oliveira on 01/08/16.
//  Updated by Andre Grillo on 31/03/20
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DocumentWebviewViewController : UIViewController
{
    WKWebView *webView;
}
@property (retain, nonatomic) WKWebView *webView;
@property (retain, nonatomic) UIButton *buttonCloseView;

-(void) loadDocumentWithUrl:(NSString *) urlString;
@end
