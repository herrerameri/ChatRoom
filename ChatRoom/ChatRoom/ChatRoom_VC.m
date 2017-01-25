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
    [self initMessages:_m_contact.name];
    m_ActionSheet.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initMessages: (NSString*) personaje{
    if(personaje == @"Harry Potter"){
        ChatData* unMensaje1 = [[ChatData alloc] init];
        unMensaje1.m_bIsMine = true;
        unMensaje1.m_eChatDataType = ChatData_Message;
        unMensaje1.m_sMessage = @"¡Harry! ¿Has visto que vienen varitas con tu foto?";
        ChatData* unMensaje2 = [[ChatData alloc] init];
        unMensaje2.m_bIsMine = false;
        unMensaje2.m_eChatDataType = ChatData_Message;
        unMensaje2.m_sMessage = @"No...¿Es una broma?";
       /* ChatData* unMensaje3 = [[ChatData alloc] init];
        unMensaje3.m_bIsMine = true;
        unMensaje3.m_eChatDataType = ChatData_Image;
        unMensaje3.m_Image = [UIImage imageNamed:@"varita.jpeg"];
        ChatData* unMensaje4 = [[ChatData alloc] init];
        unMensaje4.m_bIsMine = false;
        unMensaje4.m_eChatDataType = ChatData_Image;
        unMensaje4.m_Image = [UIImage imageNamed:@"lengua.jpg"];*/
        [m_aMessages addObject:unMensaje1];
        [m_aMessages addObject:unMensaje2];
        //[m_aMessages addObject:unMensaje3];
       // [m_aMessages addObject:unMensaje4];
    }
    else if(personaje == @"Ron Weasley"){
    
    }
    else if(personaje == @"Hermione Granger"){
    }
    else {
    }
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
    //[_m_Button_Avatar setBackgroundImage:img forState:UIControlStateNormal];
    
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatData* chatData = m_aMessages[indexPath.row];
    switch (chatData.m_eChatDataType) {
        case ChatData_Message:
        {
            if (chatData.m_bIsMine) {
                Chat_MyMessage_Cell* cell = [[Chat_MyMessage_Cell alloc] init];
                ChatData* data = m_aMessages[indexPath.row];
                [cell.message setText: data.m_sMessage];
                return cell;
            }else{
                Chat_MyMessage_Cell* cell = [[Chat_MyMessage_Cell alloc] init];
                ChatData* data = m_aMessages[indexPath.row];
                [cell.message setText: data.m_sMessage];
                return cell;
            }
        }
            break;
        case ChatData_Image:
        {
            if (chatData.m_bIsMine) {
                return nil;
            }else{
                return nil;
            }
        }
            break;
        case ChatData_None:
            NSLog(@"Error_ChatRoom:tableView--> chatData with ChatData_None value");
            return nil;
        default:
            break;
    }
    return nil;
}

 /*
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ChatData* chatData = m_aMessages[indexPath.row];
    CGFloat bubbleHeight;
    CGFloat cellHeight;
    if (chatData.m_eChatDataType == ChatData_Message){
        
        CGSize size = CGSizeMake(100, 100);//[chatData.m_sMessage sizeWithAttributes:@{NSFontAttributeName: bubbleFont}];
        
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
}*/

@end
