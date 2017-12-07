//
//  LBCountrySearchVC.h
//  Pods
//
//  Created by 李兵 on 2017/12/6.
//

#import <UIKit/UIKit.h>

@class LBCountryModel;
@interface LBCountrySearchVC : UIViewController
- (void)showCountries:(NSArray <LBCountryModel *>*)countries;

@end
