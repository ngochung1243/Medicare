//
//  ProductViewController.m
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import "ProductViewController.h"
#import "MedicareManager.h"

@interface ProductViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *savedKAOProductIds;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupNavigation];
    [self setupTableView];

    self.savedKAOProductIds = [shareMedicareManager getKAOProductsOfMedicarePlace:self.place];
}

- (void)setupNavigation {
    self.navigationItem.title = @"Sản phẩm KAO";
}

- (void)setupTableView {
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.rowHeight = 50.0f;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.editing = YES;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell description]];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return shareMedicareManager.KAOProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description] forIndexPath:indexPath];
    KaoProduct *product = shareMedicareManager.KAOProducts[indexPath.row];
    if (product.imageURL) {
        cell.imageView.image = [UIImage imageNamed:product.imageURL];
    }
    cell.textLabel.text = product.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    KaoProduct *product = shareMedicareManager.KAOProducts[indexPath.row];
    if ([self.savedKAOProductIds containsObject:product._id]) {
        cell.selected = YES;
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KaoProduct *product = shareMedicareManager.KAOProducts[indexPath.row];
    [shareMedicareManager saveKAOProduct:product toMedicarePlace:self.place];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    KaoProduct *product = shareMedicareManager.KAOProducts[indexPath.row];
    [shareMedicareManager clearKAOProduct:product atMedicarePlace:self.place];
}

@end
