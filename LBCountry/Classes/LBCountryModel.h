//
//  LBCountryModel.h
//  Pods
//
//  Created by 李兵 on 2017/12/6.
//

#import <Foundation/Foundation.h>

@interface LBCountryModel : NSObject
@property (nonatomic, copy)NSString *countryCode;
@property (nonatomic, copy)NSString *phoneCode;
@property (nonatomic, copy)NSString *countryName;
@property (nonatomic, copy)NSString *countryNameOfPinyin;

+ (NSArray <LBCountryModel *>*)allCountriesArray;
+ (NSDictionary <NSString *, LBCountryModel *>*)allCountriesDictionary;
+ (instancetype)currentCountry;
@end
