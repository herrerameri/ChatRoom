//
//  ViewController.m
//  ChatRoom
//

#import "ChatRoom_VC.h"
#import "ChatData.h"
#import "Chat_MyImage_Cell.h"
#import "Chat_MyMessage_Cell.h"
#import "Chat_OtherImage_Cell.h"
#import "Chat_OtherMessage_Cell.h"

@interface ChatRoom_VC ()
{
    NSMutableArray* m_aMessages;
    UIActionSheet*  m_ActionSheet;
    UIImagePickerController *m_ImgPicker;
}
@end

@implementation ChatRoom_VC
const int CAMARA = 0;
const int GALERIA = 1;
const int CANCELAR = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_m_name setText:_m_contact.name];
    [_m_phone setText:_m_contact.phone];
    [_m_photo setImage:_m_contact.photo];
    m_aMessages = [[NSMutableArray alloc] init];
    [self initMessages:_m_contact.name];
    m_ActionSheet.delegate = self;
    
    [_chatTable setBackgroundView:nil];
    [_chatTable setBackgroundColor:[UIColor clearColor]];
    
    // Keyboard events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) initMessages: (NSString*) personaje{
    NSDate *otherDay = [NSDate date];
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    [dc setDay:-1];
    otherDay = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:otherDay options:0];
    NSMutableArray* seccion = [[NSMutableArray alloc] init];
    
    if([personaje  isEqualToString: @"Harry Potter"]){
        ChatData* unMensaje1 = [[ChatData alloc] init];
        unMensaje1.m_bIsMine = true;
        unMensaje1.m_eChatDataType = ChatData_Message;
        unMensaje1.m_Date = otherDay;
        unMensaje1.m_sMessage = @"¡Harry! ¿Has visto que vienen varitas con tu foto?";
        ChatData* unMensaje2 = [[ChatData alloc] init];
        unMensaje2.m_bIsMine = false;
        unMensaje2.m_Date = otherDay;
        unMensaje2.m_eChatDataType = ChatData_Message;
        unMensaje2.m_sMessage = @"No...¿Es una broma?";
        ChatData* unMensaje3 = [[ChatData alloc] init];
        unMensaje3.m_bIsMine = true;
        unMensaje3.m_Date = otherDay;
        unMensaje3.m_eChatDataType = ChatData_Image;
        unMensaje3.m_Image = [UIImage imageNamed:@"varita.jpeg"];
        ChatData* unMensaje4 = [[ChatData alloc] init];
        unMensaje4.m_bIsMine = false;
        unMensaje4.m_Date = otherDay;
        unMensaje4.m_eChatDataType = ChatData_Image;
        unMensaje4.m_Image = [UIImage imageNamed:@"lengua.jpg"];
        [seccion addObject:unMensaje1];
        [seccion addObject:unMensaje2];
        [seccion addObject:unMensaje3];
        [seccion addObject:unMensaje4];
        
    }
    else if([personaje isEqualToString: @"Ron Weasley"]){
        ChatData* unMensaje1 = [[ChatData alloc] init];
        unMensaje1.m_bIsMine = true;
        unMensaje1.m_Date = otherDay;
        unMensaje1.m_eChatDataType = ChatData_Message;
        unMensaje1.m_sMessage = @"¡Hola Ron! ¿Qué haces hoy?";
        ChatData* unMensaje2 = [[ChatData alloc] init];
        unMensaje2.m_bIsMine = false;
        unMensaje2.m_Date = otherDay;
        unMensaje2.m_eChatDataType = ChatData_Message;
        unMensaje2.m_sMessage = @"¡Estoy comiendo las nuevas grageas de todos los sabores! Mira:";
        ChatData* unMensaje3 = [[ChatData alloc] init];
        unMensaje3.m_bIsMine = true;
        unMensaje3.m_Date = otherDay;
        unMensaje3.m_eChatDataType = ChatData_Image;
        unMensaje3.m_Image = [UIImage imageNamed:@"sorpresa.jpeg"];
        ChatData* unMensaje4 = [[ChatData alloc] init];
        unMensaje4.m_bIsMine = false;
        unMensaje4.m_Date = otherDay;
        unMensaje4.m_eChatDataType = ChatData_Image;
        unMensaje4.m_Image = [UIImage imageNamed:@"grageas.jpeg"];
        [seccion addObject:unMensaje1];
        [seccion addObject:unMensaje2];
        [seccion addObject:unMensaje4];
        [seccion addObject:unMensaje3];
    }
    else if([personaje isEqualToString: @"Hermione Granger"]){
        ChatData* unMensaje1 = [[ChatData alloc] init];
        unMensaje1.m_bIsMine = false;
        unMensaje1.m_Date = otherDay;
        unMensaje1.m_eChatDataType = ChatData_Message;
        unMensaje1.m_sMessage = @"Mmm... no. El patronus de Harry es este:";
        ChatData* unMensaje2 = [[ChatData alloc] init];
        unMensaje2.m_bIsMine = true;
        unMensaje2.m_Date = otherDay;
        unMensaje2.m_eChatDataType = ChatData_Message;
        unMensaje2.m_sMessage = @"¡Hola! ¿Sabes si Harry ha estado por el bosque hoy? Me pareció ver su patronus.";
        ChatData* unMensaje3 = [[ChatData alloc] init];
        unMensaje3.m_bIsMine = false;
        unMensaje3.m_Date = otherDay;
        unMensaje3.m_eChatDataType = ChatData_Image;
        unMensaje3.m_Image = [UIImage imageNamed:@"patronus.jpeg"];
        ChatData* unMensaje4 = [[ChatData alloc] init];
        unMensaje4.m_bIsMine = true;
        unMensaje4.m_eChatDataType = ChatData_Image;
        unMensaje4.m_Date = otherDay;
        unMensaje4.m_Image = [UIImage imageNamed:@"patronus2.jpeg"];
        [seccion addObject:unMensaje2];
        [seccion addObject:unMensaje4];
        [seccion addObject:unMensaje1];
        [seccion addObject:unMensaje3];
    }
    else {
        ChatData* unMensaje1 = [[ChatData alloc] init];
        unMensaje1.m_bIsMine = true;
        unMensaje1.m_Date = otherDay;
        unMensaje1.m_eChatDataType = ChatData_Message;
        unMensaje1.m_sMessage = @"¡Profesor!¿Es este el libro que usaremos en DCAO?";
        ChatData* unMensaje2 = [[ChatData alloc] init];
        unMensaje2.m_bIsMine = false;
        unMensaje2.m_Date = otherDay;
        unMensaje2.m_eChatDataType = ChatData_Message;
        unMensaje2.m_sMessage = @"No...Este año usaremos este:";
        ChatData* unMensaje3 = [[ChatData alloc] init];
        unMensaje3.m_bIsMine = true;
        unMensaje3.m_Date = otherDay;
        unMensaje3.m_eChatDataType = ChatData_Image;
        unMensaje3.m_Image = [UIImage imageNamed:@"libro.jpg"];
        ChatData* unMensaje4 = [[ChatData alloc] init];
        unMensaje4.m_bIsMine = false;
        unMensaje4.m_Date = otherDay;
        unMensaje4.m_eChatDataType = ChatData_Image;
        unMensaje4.m_Image = [UIImage imageNamed:@"libro2.jpg"];
        [seccion addObject:unMensaje1];
        [seccion addObject:unMensaje3];
        [seccion addObject:unMensaje2];
        [seccion addObject:unMensaje4];
    }
    [m_aMessages addObject:seccion];
}

- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)moreOptions:(id)sender {
    m_ActionSheet = [[UIActionSheet alloc] initWithTitle:   @"Foto" delegate:   self cancelButtonTitle:   @"Cancelar"
                                  destructiveButtonTitle:   nil
                                       otherButtonTitles:   @"Cámara",@"Galería", nil];
    [m_ActionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

- (IBAction)sendMessage:(id)sender {
    if(_messageUser.text.length > 0)
    {
        ChatData* unMensaje1 = [[ChatData alloc] init];
        unMensaje1.m_bIsMine = true;
        unMensaje1.m_eChatDataType = ChatData_Message;
        unMensaje1.m_sMessage = _messageUser.text;
        unMensaje1.m_Date =  [NSDate date];
        ChatData* unMensaje2 = [[ChatData alloc] init];
        unMensaje2.m_bIsMine = false;
        unMensaje2.m_eChatDataType = ChatData_Message;
        unMensaje2.m_sMessage = _messageUser.text;
        unMensaje2.m_Date =  [NSDate date];
        
        [self agregarMensaje: unMensaje1];
        [self agregarMensaje: unMensaje2];
        
        [_messageUser setText:@""];
        [_chatTable reloadData];
        [self goToLastMessage];
    }
}

-(void) agregarMensaje: (ChatData*) chatData{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *stringDateHoy = [dateFormat stringFromDate:chatData.m_Date];
    bool existingSection = false;
    
    for(int i = 0; i < m_aMessages.count; i++)
    {
        NSMutableArray* section = [m_aMessages objectAtIndex:i];
        ChatData* data = [section objectAtIndex:0];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *stringDateSection = [dateFormat stringFromDate:data.m_Date];
        
        if([stringDateHoy isEqualToString:stringDateSection]){
            [section addObject:chatData];
            existingSection = true;
        }
    }
    
    if(!existingSection)
    {
        NSMutableArray* newSection = [[NSMutableArray alloc] initWithObjects:chatData, nil];
        [m_aMessages addObject:newSection];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case CAMARA:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                if (m_ImgPicker == nil)
                {
                    m_ImgPicker = [[UIImagePickerController alloc] init];
                }
                m_ImgPicker.allowsEditing = YES;
                m_ImgPicker.delegate = self;
                m_ImgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:m_ImgPicker animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alerta =
                [UIAlertController alertControllerWithTitle:@"¡Oh!"
                                                    message:@"No es posible acceder a tu cámara."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alerta dismissViewControllerAnimated:YES completion:nil];
                                     }];
                
                [alerta addAction:ok];
                [self presentViewController:alerta animated:YES completion:nil];
            }
        }
        break;
            
        case GALERIA:
        {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                if (m_ImgPicker == nil)
                    m_ImgPicker = [[UIImagePickerController alloc] init];
                
                m_ImgPicker.allowsEditing = YES;
                m_ImgPicker.delegate = self;
                m_ImgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:m_ImgPicker animated:YES completion:nil];
            }
            else
            {
                UIAlertController *alerta =
                [UIAlertController alertControllerWithTitle:@"¡Oh!"
                                                    message:@"No es posible acceder a tu galería."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alerta dismissViewControllerAnimated:YES completion:nil];
                                     }];
                
                [alerta addAction:ok];

                [self presentViewController:alerta animated:YES completion:nil];
            }

        }
        break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    [self dismissModalViewControllerAnimated:YES];
    ChatData* unMensaje1 = [[ChatData alloc] init];
    unMensaje1.m_bIsMine = true;
    unMensaje1.m_eChatDataType = ChatData_Image;
    unMensaje1.m_Image = img;
    unMensaje1.m_Date = [NSDate date];
    ChatData* unMensaje2 = [[ChatData alloc] init];
    unMensaje2.m_bIsMine = false;
    unMensaje2.m_eChatDataType = ChatData_Image;
    unMensaje2.m_Image = img;
    unMensaje2.m_Date = [NSDate date];
    [self agregarMensaje:unMensaje1];
    [self agregarMensaje:unMensaje2];
    [_chatTable reloadData];
    [self goToLastMessage];
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return m_aMessages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray* elementosSeccion = [m_aMessages objectAtIndex:section];
    return elementosSeccion.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray* section = m_aMessages[indexPath.section];
    ChatData* chatData = section[indexPath.row];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    
    switch (chatData.m_eChatDataType) {
        case ChatData_Message:
        {
            if (chatData.m_bIsMine) {
                static NSString *CellIdentifier = @"Chat_Msg_Cell";
                Chat_MyMessage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil)
                {
                    cell = [[Chat_MyMessage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.hour setText: [dateFormat stringFromDate:chatData.m_Date]];
                [cell.message setText: chatData.m_sMessage];
                return cell;
            }else{
                static NSString *CellIdentifier = @"Chat_MsgOthers_Cell";
                Chat_OtherMessage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil)
                {
                    cell = [[Chat_OtherMessage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.hour setText: [dateFormat stringFromDate:chatData.m_Date]];
                [cell.message setText: chatData.m_sMessage];
                return cell;
            }
        }
            break;
        case ChatData_Image:
        {
            if (chatData.m_bIsMine) {
                static NSString *CellIdentifier = @"Chat_MyImage_Cell";
                Chat_MyImage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil)
                {
                    cell = [[Chat_MyImage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.hour setText: [dateFormat stringFromDate:chatData.m_Date]];
                [cell.image setImage: chatData.m_Image];
                return cell;
            }else{
                static NSString *CellIdentifier = @"Chat_OtherImage_Cell";
                Chat_OtherImage_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil)
                {
                    cell = [[Chat_OtherImage_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                [cell.hour setText: [dateFormat stringFromDate:chatData.m_Date]];
                [cell.image setImage: chatData.m_Image];
                return cell;
            }
        }
            break;
        case ChatData_None:
            return nil;
        default:
            break;
    }
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray* section = m_aMessages[indexPath.section];
    ChatData* chatData = section[indexPath.row];
    CGFloat bubbleHeight;
    CGFloat cellHeight;
    if (chatData.m_eChatDataType == ChatData_Message){
        
        CGSize size = [chatData.m_sMessage sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14]}];
        
        bubbleHeight= ((size.width/250)*size.height) +size.height;
        
        if (bubbleHeight < 34)
        {
            bubbleHeight = 34;
        }
        cellHeight = bubbleHeight + 36;
        
    }else
    {
        cellHeight = 104;
    }
    
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSMutableArray* sectionArray = [m_aMessages objectAtIndex:section];
    ChatData* data = [sectionArray objectAtIndex:0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *sectionHeader = [dateFormat stringFromDate:data.m_Date];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((tableView.frame.size.width/2)-20, 5, tableView.frame.size.width, 10)];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:10]];
    
    [label setText:sectionHeader];
    [view addSubview:label];
    [view setBackgroundColor:
    [UIColor colorWithRed:32/255.0 green:162/255.0 blue:189/255.0 alpha:1.0]];
    return view;
}

#pragma mark - Keyboard events
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = _toolbar.frame;
        frame.origin.y -= kbSize.height;
        _toolbar.frame = frame;
        
        frame = _chatTable.frame;
        frame.size.height -= kbSize.height;
        _chatTable.frame = frame;
        [self goToLastMessage];
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = _toolbar.frame;
        frame.origin.y += kbSize.height;
        _toolbar.frame = frame;
        
        frame = _chatTable.frame;
        frame.size.height += kbSize.height;
        _chatTable.frame = frame;
    }];
}

-(void) goToLastMessage {
    if (_chatTable.contentSize.height > _chatTable.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, _chatTable.contentSize.height - _chatTable.frame.size.height);
        [_chatTable setContentOffset:offset animated:YES];
    }
}

@end
