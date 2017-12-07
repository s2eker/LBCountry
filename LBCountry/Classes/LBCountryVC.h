//
//  LBCountryVC.h
//  Pods
//
//  Created by 李兵 on 2017/12/6.
//

#import <UIKit/UIKit.h>
#import "LBCountryModel.h"

typedef void (^LBCountryUIConfig)(UISearchController *searchVC);

@interface LBCountryVC : UIViewController

@property (nonatomic, copy) LBCountrySelectBlock selectCountry;
@property (nonatomic, copy) LBCountryUIConfig uiConfig;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, assign) BOOL showPhoneCodePlus;


@end
