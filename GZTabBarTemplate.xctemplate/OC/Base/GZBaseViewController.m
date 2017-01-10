//
//  ___FILENAME___
//  ___PROJECTNAME___
//  
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAME___ ()

@end

@implementation ___FILEBASENAME___

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  打开FPS检测
     *
     *  #if TARGET_IPHONE_SIMULATOR
     *  [KMCGeigerCounter sharedGeigerCounter].enabled = YES;
     *  #endif
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
