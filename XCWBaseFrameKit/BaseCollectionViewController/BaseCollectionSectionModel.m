//
//  BaseCollectionSectionModel.m
//  SDUSZ_ELearningPlatform
//
//  Created by sdusz on 2019/1/7.
//  Copyright © 2019年 juziwl. All rights reserved.
//

#import "BaseCollectionSectionModel.h"
#import <os/lock.h>
#import "XCWBaseKitHeader.h"

@interface BaseCollectionSectionModel ()
{
    os_unfair_lock _lock;
}
@property (strong, nonatomic) NSMutableArray <BaseCollectionCellModel *> * objects;//存储BaseCollectionCellModel
@end

@implementation BaseCollectionSectionModel

//section 添加元素(加到最后面)
- (void)addCellModel:(__kindof BaseCollectionCellModel *)cellModel{
    
    if (cellModel) {
        [self lock];
        [self.objects addObject:cellModel];
        [self unlock];
    }
}

//从数组添加
- (void)addCellModelsFromArray:(NSArray <__kindof BaseCollectionCellModel *>*)arr{
    
    [self lock];
    [arr enumerateObjectsUsingBlock:^(__kindof BaseCollectionCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (obj) {
            [self.objects addObject:obj];
        }
    }];
    [self unlock];
}

//在指定index插入元素
- (void)insertCellModel:(__kindof BaseCollectionCellModel *)cellModel atIndex:(NSInteger)index{
    
    if (index >= self.objects.count) {
        NSAssert(NO, @"数组越界");
        return;
    }
    [self lock];
    [self.objects insertObject:cellModel atIndex:index];
    [self unlock];
}
//section 移除指定index的元素
- (void)removeCellModelAtIndex:(NSInteger)index{
    if (index >= self.objects.count) {
        NSAssert(NO, @"数组越界");
        return;
    }
    [self lock];
    [self.objects removeObjectAtIndex:index];
    [self unlock];
}

- (void)removeCellModel:(__kindof BaseCollectionCellModel *)cellModel{
    
    [self lock];
    [self.objects removeObject:cellModel];
    [self unlock];
}

//移除所有元素
- (void)removeAllCellModels{
    
    [self lock];
    [self.objects removeAllObjects];
    [self unlock];
}
//获取指定位置的元素
- (__kindof BaseCollectionCellModel *)cellModelAtIndex:(NSInteger)index{
    
    if (index >= self.objects.count) {
        NSAssert(NO, @"数组越界");
        return nil;
    }
    [self lock];
    id obj = self.objects[index];
    [self unlock];
    return obj;
}

//获取cellModel的index
- (NSInteger)indexOfCellModel:(__kindof BaseCollectionCellModel *)cellModel{
    
    @try{
        [self lock];
        NSInteger index = [self.objects indexOfObject:cellModel];
        [self unlock];
        return index;
    }
    @catch(NSException *exc){
        
    }
}

//交换两个位置的元素
- (void)switchCellModelAtIndex:(NSInteger)index0 withCellModelAtIndex:(NSInteger)index1{
    
    if (index0 >= self.objects.count || index1 >= self.objects.count) {
        NSAssert(NO, @"数组越界");
        return;
    }
    [self lock];
    [self.objects exchangeObjectAtIndex:index0 withObjectAtIndex:index1];
    [self unlock];
}

//获取所有的元素
- (NSArray <__kindof BaseCollectionCellModel *> *)getAllCellModels{
    
    return self.objects;
}

- (void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(__kindof BaseCollectionCellModel * obj, NSUInteger idx, BOOL *stop))block{
    [self lock];
    [self.objects enumerateObjectsUsingBlock:block];
    [self unlock];
}

- (BOOL)isLastItem:(__kindof BaseCollectionCellModel *)cellModel{
    
    if (self.objects.count==0) {
        return YES;
    }
    BOOL _isLast = [cellModel isEqual:self.objects.lastObject];
    
    return _isLast;
}

- (BaseCollectionCellModel *)selectedCellModel {
    if (_selectedIndex >= self.objects.count) return nil;
    return self.objects[_selectedIndex];
}

- (void)lock
{
    os_unfair_lock_lock(&_lock);
}

- (void)unlock
{
    os_unfair_lock_unlock(&_lock);
}

# pragma mark -override

- (NSString *)headerViewClass{
    
    if (!_headerViewClass) {
        _headerViewClass= @"BaseCollectionReusableViewHeader";
    }
    return _headerViewClass;
}

- (NSString *)footerViewClass{
    
    if (!_footerViewClass) {
        _footerViewClass = @"BaseCollectionReusableViewFooter";
    }
    return _footerViewClass;
}

# pragma mark - getter
- (NSMutableArray <BaseCollectionCellModel *> *)objects{
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    return _objects;
}

- (NSInteger)cellModelCount{
    
    return [self.objects count];
}
@end
