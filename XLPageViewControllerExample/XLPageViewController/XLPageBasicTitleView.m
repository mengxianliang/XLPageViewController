//
//  XLPageBasicTitleView.m
//  XLPageViewControllerExample
//
//  Created by MengXianLiang on 2019/5/8.
//  Copyright © 2019 jwzt. All rights reserved.
//

#import "XLPageBasicTitleView.h"
#import "XLPageViewControllerUtil.h"

#pragma mark - cell类
#pragma mark UICollectionViewCell
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
        self.textLabel.textAlignment = NSTextAlignmentCenter;
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


#pragma mark - 布局类
#pragma mark XLPageBasicTitleViewFolowLayout
@interface XLPageBasicTitleViewFolowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) XLPageTitleViewAlignment alignment;

@property (nonatomic, assign) UIEdgeInsets originSectionInset;

@end

@implementation XLPageBasicTitleViewFolowLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGRect targetRect = rect;
    targetRect.size = self.collectionView.bounds.size;
    //获取屏幕上所有布局文件
    NSArray *attributes = [super layoutAttributesForElementsInRect:targetRect];
    //获取所有item个数
    CGFloat totalItemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    //如果屏幕未被item充满，执行以下布局，否则保持标准布局
    if (attributes.count < totalItemCount) {return [super layoutAttributesForElementsInRect:rect];}
    //计算缩进
    UICollectionViewLayoutAttributes *firstAttribute = attributes.firstObject;
    UICollectionViewLayoutAttributes *lastAttribute = attributes.lastObject;
    CGFloat attributesFullWidth = CGRectGetMaxX(lastAttribute.frame) - CGRectGetMinX(firstAttribute.frame);
    CGFloat emptyWidth = self.collectionView.bounds.size.width - attributesFullWidth;
    
    CGFloat insetLeft = 0;
    if (self.alignment == XLPageTitleViewAlignmentLeft) {
        insetLeft = self.originSectionInset.left;
    }
    if (self.alignment == XLPageTitleViewAlignmentCenter) {
        insetLeft = emptyWidth/2.0f;
    }
    if (self.alignment == XLPageTitleViewAlignmentRight) {
        insetLeft = emptyWidth - self.originSectionInset.right;
    }
    
    //兼容防止出错
    insetLeft = insetLeft <= self.originSectionInset.left ? self.originSectionInset.left : insetLeft;
    
    self.sectionInset = UIEdgeInsetsMake(self.sectionInset.top, insetLeft, self.sectionInset.bottom, self.sectionInset.right);
    return [super layoutAttributesForElementsInRect:rect];
}

@end

#pragma mark - 标题类
#pragma mark XLPageBasicTitleView
@interface XLPageBasicTitleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//集合视图
@property (nonatomic, strong) UICollectionView *collectionView;

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

//阴影线条
@property (nonatomic, strong) UIView *shadowLine;

//底部分割线
@property (nonatomic, strong) UIView *separatorLine;

//上一次选中的位置
@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation XLPageBasicTitleView

- (instancetype)initWithConfig:(XLPageViewControllerConfig *)config {
    if (self = [super init]) {
        [self initTitleViewWithConfig:config];
    }
    return self;
}

- (void)initTitleViewWithConfig:(XLPageViewControllerConfig *)config {
    
    self.config = config;
    
    XLPageBasicTitleViewFolowLayout *layout = [[XLPageBasicTitleViewFolowLayout alloc] init];
    layout.alignment = self.config.titleViewAlignment;
    layout.originSectionInset = self.config.titleViewInsets;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = config.titleViewInsets;
    layout.minimumInteritemSpacing = config.titleSpace;
    layout.minimumLineSpacing = config.titleSpace;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[XLPageTitleCell class] forCellWithReuseIdentifier:@"XLPageTitleCell"];
    self.collectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:self.collectionView];
    
    self.separatorLine = [[UIView alloc] init];
    self.separatorLine.backgroundColor = config.separatorLineColor;
    self.separatorLine.hidden = config.hideSeparatorLine;
    [self addSubview:self.separatorLine];
    
    self.shadowLine = [[UIView alloc] init];
    self.shadowLine.bounds = CGRectMake(0, 0, self.config.shadowLineWidth, self.config.shadowLineHeight);
    self.shadowLine.backgroundColor = config.shadowLineColor;
    self.shadowLine.layer.cornerRadius =  self.config.shadowLineHeight/2.0f;
    if (self.config.shadowLineCap == XLshadowLineCapSquare) {
        self.shadowLine.layer.cornerRadius = 0;
    }
    self.shadowLine.layer.masksToBounds = true;
    self.shadowLine.hidden = config.hideShadowLine;
    [self.collectionView addSubview:self.shadowLine];
    
    self.stopAnimation = false;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.separatorLine.frame = CGRectMake(0, self.bounds.size.height - self.config.separatorLineHeight, self.bounds.size.width, self.config.separatorLineHeight);
    self.shadowLine.center = [self shadowLineCenterForIndex:_selectedIndex];
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
    cell.textFont = indexPath.row == self.selectedIndex ? self.config.titleSelectedFont : self.config.titleNormalFont;
    cell.text = [self.dataSource pageTitleViewTitleForIndex:indexPath.row];
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
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath1,indexPath2]];
    }];
    
    
    //自动居中
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    
    //设置阴影位置
    self.shadowLine.center = [self shadowLineCenterForIndex:_selectedIndex];
    
    //保存上次选中位置
    _lastSelectedIndex = _selectedIndex;
}

- (void)setAnimationProgress:(CGFloat)animationProgress {
    if (self.stopAnimation) {return;}
    if (animationProgress == 0) {return;}
    
    NSInteger targetIndex = animationProgress < 0 ? _selectedIndex - 1 : _selectedIndex + 1;
    if (targetIndex < 0 || targetIndex >= [self.dataSource pageTitleViewNumberOfTitle]) {return;}
    
    //设置颜色切换动画
    XLPageTitleCell *currentCell = (XLPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
    XLPageTitleCell *targetCell = (XLPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:targetIndex inSection:0]];
    
    currentCell.textColor = [XLPageViewControllerUtil colorTransformFrom:self.config.titleSelectedColor to:self.config.titleNormalColor progress:fabs(animationProgress)];
    
    targetCell.textColor = [XLPageViewControllerUtil colorTransformFrom:self.config.titleNormalColor to:self.config.titleSelectedColor progress:fabs(animationProgress)];
    
    CGFloat distance = targetCell.center.x - currentCell.center.x;
    CGFloat centerX = currentCell.center.x + fabs(animationProgress)*distance;
    CGFloat centerY = self.shadowLine.center.y;
    self.shadowLine.center = CGPointMake(centerX, centerY);
}

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark 阴影位置
- (CGPoint)shadowLineCenterForIndex:(NSInteger)index {
    XLPageTitleCell *cell = (XLPageTitleCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGFloat centerX = cell.center.x;
    CGFloat centerY = self.bounds.size.height - self.config.shadowLineHeight/2.0f - self.config.separatorLineHeight;
    return CGPointMake(centerX, centerY);
}

#pragma mark -
#pragma mark 辅助方法
- (CGFloat)widthForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.config.titleWidth > 0) {
        return self.config.titleWidth;
    }
    CGFloat selectedWidth = [XLPageViewControllerUtil widthForText:[self.dataSource pageTitleViewTitleForIndex:indexPath.row] font:self.config.titleSelectedFont size:self.bounds.size];
    
    CGFloat normalWidth = [XLPageViewControllerUtil widthForText:[self.dataSource pageTitleViewTitleForIndex:indexPath.row] font:self.config.titleNormalFont size:self.bounds.size];
    
    return selectedWidth > normalWidth ? selectedWidth : normalWidth;
}

@end
