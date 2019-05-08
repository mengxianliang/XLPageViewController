//
//  XLPageTitleView.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "XLPageTitleView.h"
#import "XLPageViewControllerUtil.h"

static CGFloat AnimationLineHeight = 3.0f;

static CGFloat AnimationLineWidth = 30.0f;

static CGFloat BottomLineHeight = 0.5f;

@interface XLPageTitleCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIFont *textFont;

@end

@implementation XLPageTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
}

- (void)setText:(NSString *)text {
    self.textLabel.text = text;
}

- (void)setTextColor:(UIColor *)textColor {
    self.textLabel.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont {
    self.textLabel.font = textFont;
}

@end

@interface XLPageTitleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//集合视图
@property (nonatomic, strong) UICollectionView *collectionView;

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

//动画线条
@property (nonatomic, strong) UIView *animationLine;

//底部分割线
@property (nonatomic, strong) UIView *bottomLine;

//上一次选中的位置
@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation XLPageTitleView

- (instancetype)initWithConfig:(XLPageViewControllerConfig *)config {
    if (self = [super init]) {
        [self initTitleViewWithConfig:config];
    }
    return self;
}

- (void)initTitleViewWithConfig:(XLPageViewControllerConfig *)config {
    self.config = config;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, config.titleInsetX, 0, config.titleInsetX);
    layout.minimumInteritemSpacing = config.titleSpace;
    layout.minimumLineSpacing = config.titleSpace;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[XLPageTitleCell class] forCellWithReuseIdentifier:@"XLPageTitleCell"];
    self.collectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:self.collectionView];
    
    self.stopAnimation = false;
    
    self.bottomLine = [[UIView alloc] init];
    self.bottomLine.backgroundColor = config.bottomLineColor;
    self.bottomLine.hidden = config.hideBottomLine;
    [self addSubview:self.bottomLine];
    
    self.animationLine = [[UIView alloc] init];
    self.animationLine.bounds = CGRectMake(0, 0, AnimationLineWidth, AnimationLineHeight);
    self.animationLine.backgroundColor = config.titleSelectedColor;
    self.animationLine.layer.cornerRadius = AnimationLineHeight/2.0f;
    self.animationLine.layer.masksToBounds = true;
    self.animationLine.hidden = config.hideAnimationLine;
    [self.collectionView addSubview:self.animationLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.bottomLine.frame = CGRectMake(0, self.bounds.size.height - BottomLineHeight, self.bounds.size.width, BottomLineHeight);
    self.animationLine.center = [self animationLineCenterForIndex:_selectedIndex];
}

#pragma mark -
#pragma mark CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource pageTitleViewNumberOfTitle];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self widthForItemAtIndexPath:indexPath], collectionView.bounds.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XLPageTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XLPageTitleCell" forIndexPath:indexPath];
    cell.textColor = indexPath.row == self.selectedIndex ? self.config.titleSelectedColor : self.config.titleNormalColor;
    cell.text = [self.dataSource pageTitleViewTitleForIndex:indexPath.row];
    cell.textFont = self.config.titleFont;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate pageTitleViewDidSelectedAtIndex:indexPath.row];
    self.selectedIndex = indexPath.row;
}

#pragma mark -
#pragma mark Setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self updateLayout];
}

- (void)updateLayout {
    if (_selectedIndex == _lastSelectedIndex) {return;}
    
    //更新cellUI
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:_selectedIndex inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:_lastSelectedIndex inSection:0];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath1,indexPath2]];
    
    //自动居中
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    
    //设置动画条位置
    self.animationLine.center = [self animationLineCenterForIndex:_selectedIndex];
    
    //保存上次选中位置
    _lastSelectedIndex = _selectedIndex;
}

- (void)setAnimationProgress:(CGFloat)animationProgress {
    if (self.stopAnimation) {return;}
    if (animationProgress == 0) {return;}
    //设置颜色切换动画
    XLPageTitleCell *currentCell = (XLPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
    currentCell.textColor = [XLPageViewControllerUtil colorTransformFrom:self.config.titleSelectedColor to:self.config.titleNormalColor progress:fabs(animationProgress)];
    
    NSInteger targetIndex = animationProgress < 0 ? _selectedIndex - 1 : _selectedIndex + 1;
    if (targetIndex < 0 || targetIndex >= [self.dataSource pageTitleViewNumberOfTitle]) {return;}
    
    XLPageTitleCell *targetCell = (XLPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:0]];
    targetCell.textColor = [XLPageViewControllerUtil colorTransformFrom:self.config.titleNormalColor to:self.config.titleSelectedColor progress:fabs(animationProgress)];
    
    CGFloat distance = targetCell.center.x - currentCell.center.x;
    CGFloat centerX = currentCell.center.x + fabs(animationProgress)*distance;
    CGFloat centerY = self.animationLine.center.y;
    self.animationLine.center = CGPointMake(centerX, centerY);
    NSLog(@"centerX = %f",centerX);
    NSLog(@"progress = %f",animationProgress);
}

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark 动画条位置
- (CGPoint)animationLineCenterForIndex:(NSInteger)index {
    XLPageTitleCell *cell = (XLPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGFloat centerX = cell.center.x;
    CGFloat centerY = self.bounds.size.height - AnimationLineHeight/2.0f - BottomLineHeight;
    return CGPointMake(centerX, centerY);
}

#pragma mark -
#pragma mark 辅助方法
- (CGFloat)widthForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [XLPageViewControllerUtil widthForText:[self.dataSource pageTitleViewTitleForIndex:indexPath.row] font:self.config.titleFont size:self.bounds.size];
}

@end
