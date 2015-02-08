//
//  HorizontalSnapFlowLayout.m
//  feelAbout
//
//  Created by Jessica Berglund on 2/7/15.
//  Copyright (c) 2015 Jessica Berglund. All rights reserved.
//

#import "HorizontalSnapFlowLayout.h"



@implementation HorizontalSnapFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 10;
    self.minimumLineSpacing = 10;
    self.itemSize = CGSizeMake(205,194);
    self.sectionInset = UIEdgeInsetsMake(60, 0, 0, 0);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGPoint point = *targetContentOffset;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    // This assumes that the values of `layout.sectionInset.left` and
    // `layout.sectionInset.right` are the same with `layout.minimumInteritemSpacing`.
    // Remember that we're trying to snap to one item at a time. So one
    // visible item comprises of its width plus the left margin.
    CGFloat visibleWidth = layout.minimumInteritemSpacing + layout.itemSize.width;
    
    // It's either we go forwards or backwards, and only allowing user
    // to scroll either 1 cell left or right (can't scroll more tha 2 cells)
    int indexOfItemToSnap = round(self.previousXoffset / visibleWidth);
    if (self.previousXoffset < point.x) {
        indexOfItemToSnap++;
    } else {
        indexOfItemToSnap--;
    }
    
    // The only exemption is the last item.
    CGFloat xOffset;
    if (indexOfItemToSnap + 1 == [self.collectionView numberOfItemsInSection:0]) { // last item
        xOffset = self.collectionView.contentSize.width - self.collectionView.bounds.size.width;
    } else {
        xOffset = indexOfItemToSnap * visibleWidth;
    }
    
    self.previousXoffset = xOffset;
    *targetContentOffset = CGPointMake(xOffset, 0);
}

@end
