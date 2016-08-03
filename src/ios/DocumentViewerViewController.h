//
//  DocumentViewerViewController.h
//  OutSystems
//
//  Created by Vitor Oliveira on 01/08/16.
//
//

#import <UIKit/UIKit.h>

@interface DocumentViewerViewController : UIViewController<UIDocumentInteractionControllerDelegate>
{
    UIDocumentInteractionController *documentInteractionController;
    UIViewController *myViewController;
}

@property (retain, nonatomic) UIDocumentInteractionController *documentInteractionController;
@property (retain, nonatomic) UIViewController *myViewController;

-(BOOL) viewFile:(NSString *)filePath usingViewController: (UIViewController *) viewController;
- (BOOL)openFile:(NSURL *)URL usingViewController: (UIViewController *) viewController;

@end
