//
//  ViewController.m
//  ChatRoom
//

#import "ChatRoom_VC.h"

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
    
    m_ActionSheet.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)moreOptions:(id)sender {
    m_ActionSheet = [[UIActionSheet alloc] initWithTitle:   @"Foto"
                                                delegate:   self
                                       cancelButtonTitle:   @"CANCELAR"
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
                //TODO Show Alert View
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
                //TODO Show Alert View
            }

        }
            break;
        case CANCELAR:
        {
            //TODO...
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


@end
