//
//  LBCountrySearchVC.m
//  Pods
//
//  Created by 李兵 on 2017/12/6.
//

#import "LBCountrySearchVC.h"
#import "LBCountryModel.h"

@interface LBCountrySearchVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSArray *dataSource;
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation LBCountrySearchVC
#pragma mark -- Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}


#pragma mark -- Life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

#pragma mark -- Init
- (void)initSet {
    
}
- (void)initLayout {
    [self.view addSubview:self.tableView];
}

#pragma mark - Delegate
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}
#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    LBCountryModel *m = self.dataSource[indexPath.row];
    cell.textLabel.text = m.countryName;
    cell.detailTextLabel.text = m.phoneCode;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -- Public
- (void)showCountries:(NSArray <LBCountryModel *>*)countries {
    self.dataSource = countries;
    [self.tableView reloadData];
}

@end
