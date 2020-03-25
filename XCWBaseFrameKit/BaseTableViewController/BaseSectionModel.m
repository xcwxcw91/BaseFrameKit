//
//  BaseSectionModel.m
//  PresentPushTest
//
//  Created by Allen_Xu on 2017/12/2.
//  Copyright © 2017年 SDUSZ. All rights reserved.
//

#import "BaseSectionModel.h"
#import <os/lock.h>
#import "XCWBaseKitHeader.h"


API_AVAILABLE(ios(10.0))
@interface BaseSectionModel ()
{
    os_unfair_lock _lock;
//    OSSpinLock _spinLock;
}
@property (strong, nonatomic) NSMutableArray <BaseTableViewCellModel *> * objects;//存储BaseTableViewCellModel

@end

@implementation BaseSectionModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        _page = 1;
        _pageSize = 10;
        if (@available(iOS 10.0, *)) {
            _lock = OS_UNFAIR_LOCK_INIT;
        } else {
//            _spinLock = OS_SPINLOCK_INIT;
        }
    }
    return self;
}

//section 添加元素(加到最后面)
- (void)addCellModel:(BaseTableViewCellModel *)cellModel{
    
    if (cellModel) {
        [self lock];
        [self.objects addObject:cellModel];
        [self unlock];
    }
}

//批量添加
- (void)addCellModelsFromArray:(NSArray <BaseTableViewCellModel *>*)arr{
    
    [self lock];
    [arr enumerateObjectsUsingBlock:^(BaseTableViewCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.objects addObject:obj];
    }];
    [self unlock];
}

//在指定index插入元素
- (void)insertCellModel:(BaseTableViewCellModel *)cellModel atIndex:(NSInteger)index{
    
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

//section 移除指定model
- (void)removeCellModel:(BaseTableViewCellModel *)cellModel{
    
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
- (__kindof BaseTableViewCellModel *)cellModelAtIndex:(NSInteger)index{
    
    if (index >= self.objects.count) {
        NSAssert(NO, @"数组越界");
        return nil;
    }
    [self lock];
    id obj = self.objects[index];
    [self unlock];
    return obj;
}

//获取cellmodel所在的index cellmodel为空的情况需要注意
- (NSInteger)indexOfCellModel:(BaseTableViewCellModel *)cellModel{
    
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
- (NSArray <BaseTableViewCellModel *> *)getAllCellModels{
    
    return self.objects;
}

- (void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(BaseTableViewCellModel * obj, NSUInteger idx, BOOL *stop))block{
    [self lock];
    [self.objects enumerateObjectsUsingBlock:block];
    [self unlock];
    
}

- (void)lock
{
    if (@available(iOS 10.0, *)) {
 
        os_unfair_lock_lock(&_lock);
        
    } else {
//        OSSpinLockLock(&_spinLock);
    }
}

- (void)unlock
{
    if (@available(iOS 10.0, *)) {
        
        os_unfair_lock_unlock(&_lock);
    } else {
//        OSSpinLockUnlock(&_spinLock);
    }
}

- (NSInteger)cellModelCount{
    
    return [self.objects count];
}


# pragma mark - getter
- (NSMutableArray <BaseTableViewCellModel *> *)objects{
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    return _objects;
}



@end
