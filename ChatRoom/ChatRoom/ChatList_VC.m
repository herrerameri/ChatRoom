//
//  ChatList_VC.m
//  ChatRoom
//
//  Created by Nicolás Hechim on 22/1/17.
//  Copyright © 2017 Meri Herrera. All rights reserved.
//

#import "ChatList_VC.h"
#import "ChatRoom_VC.h"
#import "Contact.h"

@interface ChatList_VC ()
{
    NSMutableArray* m_contacts;
    Contact* m_contactSelected;
}
@end

@implementation ChatList_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    Contact* harry = [[Contact alloc] init];
    harry.name = @"Harry Potter";
    harry.phone = @"+349345456248";
    harry.photo = [UIImage imageNamed:@"Harry.jpg"];
    Contact* hermione = [[Contact alloc] init];
    hermione.name = @"Hermione Granger";
    hermione.phone = @"+349345456248";
    hermione.photo = [UIImage imageNamed:@"Hermione.jpeg"];
    Contact* ron = [[Contact alloc] init];
    ron.name = @"Ron Weasley";
    ron.phone = @"+349345456248";
    ron.photo = [UIImage imageNamed:@"Ron.jpg"];
    Contact* albus = [[Contact alloc] init];
    albus.name = @"Albus Dumbledore";
    albus.phone = @"+349345456248";
    albus.photo = [UIImage imageNamed:@"Albus.jpeg"];
    
    m_contacts = [[NSMutableArray alloc] initWithObjects:harry, albus, ron, hermione, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueToChatRoom"])
    {
        ChatRoom_VC* chatRoom = [segue destinationViewController];
        chatRoom.m_contact = m_contactSelected;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    m_contactSelected = [m_contacts objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segueToChatRoom" sender:self];
}

@end
