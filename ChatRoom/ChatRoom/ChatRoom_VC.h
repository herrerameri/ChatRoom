//
//  ViewController.h
//  ChatRoom
//
//  Created by Nicolás Hechim on 22/1/17.
//  Copyright © 2017 Meri Herrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ChatRoom_VC : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *m_name;
@property (strong, nonatomic) IBOutlet UILabel *m_phone;
@property (strong, nonatomic) IBOutlet UIImageView *m_photo;

@property (nonatomic, assign) Contact* m_contact;

- (IBAction)back:(id)sender;
- (IBAction)moreOptions:(id)sender;
- (IBAction)sendMessage:(id)sender;

@end

