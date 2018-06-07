//
//  ViewController.m
//  Medicare
//
//  Created by Mai Hưng on 6/7/18.
//  Copyright © 2018 hungmai. All rights reserved.
//

#import "MedicarePlacesViewController.h"
#import "MedicareManager.h"

@interface MedicarePlaceCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *addressLabel;
- (void)setData:(MedicarePlace *)medicarePlace;
@end

@implementation MedicarePlaceCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _addressLabel = [UILabel new];
        _addressLabel.numberOfLines = 0;
        _addressLabel.frame = frame;
        _addressLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

- (void)setData:(MedicarePlace *)medicarePlace {
    _addressLabel.text = medicarePlace.address;
}
@end


@interface MedicarePlacesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation MedicarePlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), 50.0f);
    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 32.0f);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[MedicarePlaceCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return shareMedicareManager.districts.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [shareMedicareManager getMedicarePlaceAtDistrict:shareMedicareManager.districts[section]].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MedicarePlaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *district = shareMedicareManager.districts[indexPath.section];
    MedicarePlace *place = [shareMedicareManager getMedicarePlaceAtDistrict:district][indexPath.item];
    [cell setData:place];
    return cell;
}

@end
