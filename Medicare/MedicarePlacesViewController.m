//
//  ViewController.m
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import "MedicarePlacesViewController.h"
#import "MedicareManager.h"
#import "MedicareDefines.h"
#import "ProductViewController.h"
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"

#define kAddressLabelPadding 16.0f

@interface MedicarePlaceCell : MGSwipeTableCell
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UIView  *separatorLine;
@property (strong, nonatomic) UIView  *indicatorLine;

@property (strong, nonatomic) MedicarePlace *place;
- (void)setData:(MedicarePlace *)medicarePlace;
@end

@implementation MedicarePlaceCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _addressLabel = [UILabel new];
        _addressLabel.numberOfLines = 0;
        _addressLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_addressLabel];
        
        _separatorLine = [UIView new];
        _separatorLine.backgroundColor = UIColor.grayColor;
        [self.contentView addSubview:_separatorLine];
        
        _indicatorLine = [UIView new];
        _indicatorLine.backgroundColor = RGBColor(238, 124, 166);
        //        _indicatorLine.hidden = YES;
        [self.contentView addSubview:_indicatorLine];
    }
    return self;
}

- (void)layoutSubviews {
    _addressLabel.frame = CGRectMake(kAddressLabelPadding, 0, CGRectGetWidth(self.frame) - kAddressLabelPadding, CGRectGetHeight(self.frame));
    _separatorLine.frame = CGRectMake(kAddressLabelPadding, CGRectGetMaxY(_addressLabel.frame), CGRectGetWidth(self.frame) - kAddressLabelPadding, 1.0f);
    _indicatorLine.frame = CGRectMake(0, 0, 3.0f, CGRectGetHeight(self.frame));
}

- (void)setData:(MedicarePlace *)medicarePlace {
    _addressLabel.text = medicarePlace.address;
    _place = medicarePlace;
    if ([shareMedicareManager getKAOProductsOfMedicarePlace:medicarePlace].count > 0) {
        _addressLabel.textColor = RGBColor(238, 124, 166);
        _indicatorLine.hidden = NO;
    }
    else {
        _addressLabel.textColor = UIColor.blackColor;
        _indicatorLine.hidden = YES;
    }
}
@end


@interface MedicarePlacesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation MedicarePlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setupView {
    [self setupNavigation];
    [self setupCollectionView];
}

- (void)setupNavigation {
    self.navigationItem.title = @"Cửa hàng Medicare";
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.whiteColor};
    self.navigationController.navigationBar.backgroundColor = RGBColor(123, 171, 237);
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *renewButton = [[UIBarButtonItem alloc] initWithTitle:@"Làm mới" style:UIBarButtonItemStyleDone target:self action:@selector(renew:)];
    [self.navigationItem setRightBarButtonItem:renewButton];
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), 50.0f);
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.tableView = [UITableView new];
    self.tableView.rowHeight = 50.0f;
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MedicarePlaceCell class] forCellReuseIdentifier:[MedicarePlaceCell description]];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:[UITableViewHeaderFooterView description]];
    [self.view addSubview:self.tableView];
}

- (void)renew:(UIBarButtonItem *)sender {
    [shareMedicareManager clearAllKAOProducts];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return shareMedicareManager.districts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [shareMedicareManager getMedicarePlaceAtDistrict:shareMedicareManager.districts[section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MedicarePlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:[MedicarePlaceCell description] forIndexPath:indexPath];
    NSString *district = shareMedicareManager.districts[indexPath.section];
    MedicarePlace *place = [shareMedicareManager getMedicarePlaceAtDistrict:district][indexPath.item];
    [cell setData:place];
    __weak __typeof(self) weakSelf = self;
    MGSwipeButton *renewButton = [MGSwipeButton buttonWithTitle:@"Làm mới" backgroundColor:RGBColor(240, 81, 60) callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        MedicarePlaceCell *medicareCell = (MedicarePlaceCell *)cell;
        [shareMedicareManager clearKAOProductsAtPlace:medicareCell.place];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        return YES;
    }];
//    [renewButton setTitleColor:RGBColor(123, 171, 237) forState:UIControlStateNormal];
    cell.rightButtons = @[renewButton];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[UITableViewHeaderFooterView description]];
    headerView.textLabel.textColor = UIColor.whiteColor;
    UILabel *districtTitle = [headerView viewWithTag:1];
    if (!districtTitle) {
        UIView *backgroundView = [UIView new];
        backgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 32.0f);
        backgroundView.backgroundColor = RGBColor(123, 171, 237);
        backgroundView.tag = 2;
        [headerView.contentView addSubview:backgroundView];
        
        districtTitle = [UILabel new];
        districtTitle.frame = CGRectInset(backgroundView.frame, kAddressLabelPadding, 0);
        districtTitle.textColor = UIColor.whiteColor;
        districtTitle.font = [UIFont boldSystemFontOfSize:16.0f];
        districtTitle.tag = 1;
        [headerView.contentView addSubview:districtTitle];
    }
    districtTitle.text = shareMedicareManager.districts[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([shareMedicareManager getMedicarePlaceAtDistrict:shareMedicareManager.districts[section]].count > 0) {
        return 32.0f;
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *district = shareMedicareManager.districts[indexPath.section];
    ProductViewController *productVC = [ProductViewController new];
    productVC.place = [shareMedicareManager getMedicarePlaceAtDistrict:district][indexPath.row];
    [self.navigationController pushViewController:productVC animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
