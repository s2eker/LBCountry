//
//  LBCountryVC.m
//  Pods
//
//  Created by 李兵 on 2017/12/6.
//

#import "LBCountryVC.h"
#import "LBCountrySearchVC.h"

@interface LBCountryVC ()<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, LBCountrySearchVCDelegate>
@property (nonatomic, strong)NSDictionary *dataSource;
@property (nonatomic, strong)NSArray *keys;
@property (nonatomic, strong)NSArray *searchResults;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UISearchController *searchVC;
@end

@implementation LBCountryVC
#pragma mark -- Getter
- (NSDictionary *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSDictionary dictionary];
    }
    return _dataSource;
}
- (NSArray *)keys {
    if (!_keys) {
        _keys = [self.dataSource.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
    }
    return _keys;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = self.searchVC.searchBar;
    }
    return _tableView;
}
- (UISearchController *)searchVC {
    if (!_searchVC) {
        LBCountrySearchVC *vc = [LBCountrySearchVC new];
        vc.delegate = self;
        _searchVC = [[UISearchController alloc] initWithSearchResultsController:vc];
        _searchVC.searchResultsUpdater = self;
        if (self.uiConfig) {
            self.uiConfig(_searchVC, self.tableView);
        }else {
            _searchVC.hidesNavigationBarDuringPresentation = NO;
            _searchVC.definesPresentationContext = YES;
            _searchVC.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
            _searchVC.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        }
    }
    return _searchVC;
}

- (NSString *)language {
    if (!_language) {
        _language = [NSLocale preferredLanguages].firstObject;
    }
    return _language;
}

#pragma mark -- Life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initSet];
    [self initLayout];
}

#pragma mark -- Init
- (void)initSet {
    self.dataSource = [LBCountryModel allCountriesDictionaryOfLanguage:self.language];
    self.showPhoneCodePlus = YES;
}
- (void)initLayout {
    [self.view addSubview:self.tableView];
}

#pragma mark -- Utilities
- (void)dealSelectCountry:(LBCountryModel *)country {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (self.selectCountry) {
        self.selectCountry(country);
    }
    NSLog(@"select country:%@", country);
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = self.keys[section];
    NSArray *arr = self.dataSource[key];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keys;
}
#pragma mark -- UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.keys[section];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.keys[indexPath.section];
    NSArray *arr = self.dataSource[key];
    LBCountryModel *m = arr[indexPath.row];
    m.displayCountryName = [m localizedCountryNameInLanguage:self.language];
    cell.textLabel.text = m.displayCountryName;
    cell.detailTextLabel.text = self.showPhoneCodePlus ? m.phoneCodePlus : m.phoneCode;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LBCountryModel *m = self.dataSource[self.keys[indexPath.section]][indexPath.row];
    [self dealSelectCountry:m];
}

#pragma mark -- UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *text = searchController.searchBar.text;
    if (text.length <= 0) {
        return;
    }
    __block NSString *countryName;
    __block NSMutableArray *searchResults = [NSMutableArray arrayWithCapacity:0];
    __weak typeof(self) weakSelf = self;
    [self.keys enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = weakSelf.dataSource[obj];
        for (LBCountryModel *m in arr) {
            countryName = m.displayCountryName;
            if ([countryName containsString:text] ||
                [countryName.lowercaseString containsString:text.lowercaseString] ||
                [countryName.lbc_pinyin.lowercaseString containsString:text.lowercaseString]) {
                [searchResults addObject:m];
            }
        }
    }];
    LBCountrySearchVC *vc = (LBCountrySearchVC *)searchController.searchResultsController;
    [vc showCountries:searchResults showPhoneCodePlus:self.showPhoneCodePlus];
}

#pragma mark -- LBCountrySearchVCDelegate
- (void)searchVC:(LBCountrySearchVC *)vc selectCountry:(LBCountryModel *)country {
    self.searchVC.active = NO;
    [self dealSelectCountry:country];
}

@end
