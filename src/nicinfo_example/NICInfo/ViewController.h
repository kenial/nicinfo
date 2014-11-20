//
//  ViewController.h
//  NICInfo
//
//  Created by Kenial on 11. 11. 19..
//  Copyright (c) 2011 Mind in Machine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UITextView* textview;
}

- (IBAction)showNICInfo:(id)sender;
- (IBAction)clear:(id)sender;

@end
