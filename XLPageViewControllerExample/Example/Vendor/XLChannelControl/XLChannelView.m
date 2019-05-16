//
//  XLChannelView.m
//  XLChannelControlDemo
//
//  Created by MengXianLiang on 2017/3/3.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "XLChannelView.h"
#import "XLChannelItem.h"
#import "XLChannelHeader.h"

//菜单列数
static NSInteger ColumnNumber = 4;
//横向和纵向的间距
static CGFloat CellMarginX = 15.0f;
static CGFloat CellMarginY = 10.0f;


@interface XLChannelView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) XLChannelItem *dragingItem;

@property (nonatomic, strong) NSIndexPath *dragingIndexPath;

@property (nonatomic, strong) NSIndexPath *targetIndexPath;

@end

@implementation XLChannelView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    self.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cellWidth = (self.bounds.size.width - (ColumnNumber + 1) * CellMarginX)/ColumnNumber;
    flowLayout.itemSize = CGSizeMake(cellWidth,cellWidth/2.0f);
    flowLayout.sectionInset = UIEdgeInsetsMake(CellMarginY, CellMarginX, CellMarginY, CellMarginX);
    flowLayout.minimumLineSpacing = CellMarginY;
    flowLayout.minimumInteritemSpacing = CellMarginX;
    flowLayout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 40);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[XLChannelItem class] forCellWithReuseIdentifier:@"XLChannelItem"];
    [self.collectionView registerClass:[XLChannelHeader class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XLChannelHeader"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMethod:)];
    longPress.minimumPressDuration = 0.3f;
    [self.collectionView addGestureRecognizer:longPress];
    
    self.dragingItem = [[XLChannelItem alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellWidth/2.0f)];
    self.dragingItem.hidden = true;
    [self.collectionView addSubview:self.dragingItem];
}

#pragma mark -
#pragma mark LongPressMethod
-(void)longPressMethod:(UILongPressGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:self.collectionView];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self dragBegin:point];
            break;
        case UIGestureRecognizerStateChanged:
            [self dragChanged:point];
            break;
        case UIGestureRecognizerStateEnded:
            [self dragEnd];
            break;
        default:
            break;
    }
}

//拖拽开始 找到被拖拽的item
-(void)dragBegin:(CGPoint)point{
    self.dragingIndexPath = [self getDragingIndexPathWithPoint:point];
    if (!self.dragingIndexPath) {return;}
    [self.collectionView bringSubviewToFront:self.dragingItem];
    XLChannelItem *item = (XLChannelItem*)[self.collectionView cellForItemAtIndexPath:self.dragingIndexPath];
    item.isMoving = true;
    //更新被拖拽的item
    self.dragingItem.hidden = false;
    self.dragingItem.frame = item.frame;
    self.dragingItem.title = item.title;
    [self.dragingItem setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
}

//正在被拖拽、、、
-(void)dragChanged:(CGPoint)point{
    if (!self.dragingIndexPath) {return;}
    self.dragingItem.center = point;
    self.targetIndexPath = [self getTargetIndexPathWithPoint:point];
    //交换位置 如果没有找到self.targetIndexPath则不交换位置
    if (self.dragingIndexPath && self.targetIndexPath) {
        //更新数据源
        [self rearrangeInUseTitles];
        //更新item位置
        [self.collectionView moveItemAtIndexPath:self.dragingIndexPath toIndexPath:self.targetIndexPath];
        self.dragingIndexPath = self.targetIndexPath;
    }
}

//拖拽结束
-(void)dragEnd{
    if (!self.dragingIndexPath) {return;}
    CGRect endFrame = [self.collectionView cellForItemAtIndexPath:self.dragingIndexPath].frame;
    [self.dragingItem setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    [UIView animateWithDuration:0.3 animations:^{
        self.dragingItem.frame = endFrame;
    }completion:^(BOOL finished) {
        self.dragingItem.hidden = true;
        XLChannelItem *item = (XLChannelItem*)[self.collectionView cellForItemAtIndexPath:self.dragingIndexPath];
        item.isMoving = false;
    }];
}

#pragma mark -
#pragma mark 辅助方法

//获取被拖动IndexPath的方法
-(NSIndexPath*)getDragingIndexPathWithPoint:(CGPoint)point{
    NSIndexPath* dragIndexPath = nil;
    //最后剩一个怎不可以排序
    if ([self.collectionView numberOfItemsInSection:0] == 1) {return dragIndexPath;}
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
        //下半部分不需要排序
        if (indexPath.section > 0) {continue;}
        //在上半部分中找出相对应的Item
        if (CGRectContainsPoint([self.collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            if (indexPath.row != 0) {
                dragIndexPath = indexPath;
            }
            break;
        }
    }
    return dragIndexPath;
}

//获取目标IndexPath的方法
-(NSIndexPath*)getTargetIndexPathWithPoint:(CGPoint)point{
    NSIndexPath *targetIndexPath = nil;
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
        //如果是自己不需要排序
        if ([indexPath isEqual:self.dragingIndexPath]) {continue;}
        //第二组不需要排序
        if (indexPath.section > 0) {continue;}
        //在第一组中找出将被替换位置的Item
        if (CGRectContainsPoint([self.collectionView cellForItemAtIndexPath:indexPath].frame, point)) {
            if (indexPath.row != 0) {
                targetIndexPath = indexPath;
            }
        }
    }
    return targetIndexPath;
}

#pragma mark -
#pragma mark CollectionViewDelegate&DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section == 0 ? self.enabledTitles.count : self.disabledTitles.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    XLChannelHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XLChannelHeader" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        headerView.title = @"已选频道";
        headerView.subTitle = @"按住拖动调整排序";
    }else{
        headerView.title = @"推荐频道";
        headerView.subTitle = @"";
    }
    return headerView;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"XLChannelItem";
    XLChannelItem* item = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    item.title = indexPath.section == 0 ? self.enabledTitles[indexPath.row] : self.disabledTitles[indexPath.row];
    item.isFixed = indexPath.section == 0 && indexPath.row == 0;
    return  item;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //只剩一个的时候不可删除
        if ([self.collectionView numberOfItemsInSection:0] == 1) {return;}
        //第一个不可删除
        if (indexPath.row  == 0) {return;}
        id obj = [self.enabledTitles objectAtIndex:indexPath.row];
        [self.enabledTitles removeObject:obj];
        [self.disabledTitles insertObject:obj atIndex:0];
        [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    }else{
        id obj = [self.disabledTitles objectAtIndex:indexPath.row];
        [self.disabledTitles removeObject:obj];
        [self.enabledTitles addObject:obj];
        [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:self.enabledTitles.count - 1 inSection:0]];
    }
}

#pragma mark -
#pragma mark 刷新方法
//拖拽排序后需要重新排序数据源
-(void)rearrangeInUseTitles
{
    id obj = [self.enabledTitles objectAtIndex:self.dragingIndexPath.row];
    [self.enabledTitles removeObject:obj];
    [self.enabledTitles insertObject:obj atIndex:self.targetIndexPath.row];
}

-(void)reloadData
{
    [self.collectionView reloadData];
}

@end
