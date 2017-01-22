//
//  Contact.h
//  ChatRoom
//
//  Created by Nicolás Hechim on 22/1/17.
//  Copyright © 2017 Meri Herrera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contact : NSObject
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) UIImage* photo;
@end
