//
//  do_HashData_MM.m
//  DoExt_MM
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_HashData_MM.h"

#import "doScriptEngineHelper.h"
#import "doIScriptEngine.h"
#import "doInvokeResult.h"
#import "doJsonHelper.h"


@implementation do_HashData_MM
{
    @private
    NSMutableDictionary* dict;
}
#pragma mark doIHashData
-(NSArray*) GetAllKey
{
    return dict.allKeys;
}
-(id) GetData:(NSString*) key
{
    return [dict objectForKey:key];
}
-(void) SetData:(NSString*) key :(id) data
{
    [dict setValue:data forKey:key];
}
-(NSString*) Serialize
{
    return[doJsonHelper ExportToText:dict :YES];
}
-(id) UnSerialize:(NSString*) str
{
    dict = [doJsonHelper LoadDataFromText:str];
    return self;
}
#pragma mark - 注册属性（--属性定义--）
/*
 [self RegistProperty:[[doProperty alloc]init:@"属性名" :属性类型 :@"默认值" : BOOL:是否支持代码修改属性]];
 */
-(void)OnInit
{
    [super OnInit];
    if(dict==nil){
        dict = [[NSMutableDictionary alloc]init];
    }
    //注册属性
}

//销毁所有的全局对象
-(void)Dispose
{
    //自定义的全局属性
    [dict removeAllObjects];
    dict = nil;
}
#pragma mark -
#pragma mark - doIDataSource implements
-(id) GetJsonData;
{
    return dict;
}

#pragma mark -
#pragma mark - 同步异步方法的实现

//同步
 - (void)addData:(NSArray *)parms
 {
     NSDictionary *_dictParas = [parms objectAtIndex:0];
     NSDictionary* datas = [doJsonHelper GetOneNode:_dictParas :@"data"];
     [dict addEntriesFromDictionary:datas];
     
 }
 - (void)addOne:(NSArray *)parms
 {
     NSDictionary *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSString* key = [doJsonHelper GetOneText: _dictParas :@"key" : @""];
     id value = [doJsonHelper GetOneValue:_dictParas :@"value"];
     [dict setObject:value forKey:key];
 }

 - (void)getCount:(NSArray *)parms
 {
     doInvokeResult *_invokeResult = [parms objectAtIndex:2];
     [_invokeResult SetResultInteger:(int)dict.count];
 }

 - (void)getData:(NSArray *)parms
 {
     NSDictionary *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSArray* keys = [doJsonHelper GetOneArray:_dictParas :@"keys"];
     NSMutableArray* result = [[NSMutableArray alloc]initWithCapacity:keys.count];
     for(NSString* key in keys)
     {
        id _jsonValue = [dict objectForKey:key];
        [result addObject:_jsonValue];
     }
     doInvokeResult *_invokeResult = [parms objectAtIndex:2];
     [_invokeResult SetResultArray:result ];

 }
 - (void)getOne:(NSArray *)parms
 {
     NSDictionary *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSString* key = [doJsonHelper GetOneText: _dictParas :@"key" : @""];
     id _jsonValue = [dict objectForKey:key];
     doInvokeResult *_invokeResult = [parms objectAtIndex:2];
     NSMutableDictionary* _node = [[NSMutableDictionary alloc]init];
     [_node setObject:_jsonValue forKey:key];
     [_invokeResult SetResultNode:_node];
 }
 - (void)removeAll:(NSArray *)parms
 {
     [dict removeAllObjects];
     //自己的代码实现
 }
 - (void)removeData:(NSArray *)parms
 {
     NSDictionary *_dictParas = [parms objectAtIndex:0];
     NSArray* keys = [doJsonHelper GetOneArray:_dictParas :@"keys"];
     [dict removeObjectsForKeys:keys];
 }
 - (void)removeOne:(NSArray *)parms
 {
     NSDictionary *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSString* key = [doJsonHelper GetOneText: _dictParas :@"key" : @""];
     if(key.length>0){
         [dict removeObjectForKey:key];
     }
 }
 - (void)updateOne:(NSArray *)parms
 {
     NSDictionary *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSString* key = [doJsonHelper GetOneText: _dictParas :@"key" : @""];
     id value = [doJsonHelper GetOneValue:_dictParas :@"value"];
     [dict setObject:value forKey:key];
 }
- (void)getAll:(NSArray *)parms
{
    doInvokeResult *_invokeResult = [parms objectAtIndex:2];
    [_invokeResult SetResultNode:dict];
}
//异步

@end