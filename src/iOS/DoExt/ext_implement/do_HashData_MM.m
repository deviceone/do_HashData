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
#import "doJsonNode.h"
#import "doJsonValue.h"

@implementation do_HashData_MM
{
    @private
    doJsonNode* dict;
}
#pragma mark doIHashData
-(NSArray*) GetAllKey
{
    return dict.dictValues.allKeys;
}
-(id) GetData:(NSString*) key
{
    return [dict GetOneValue:key];
}
-(void) SetData:(NSString*) key :(id) data
{
    [dict SetOneValue:key :data ];
}
-(NSString*) Serialize
{
    return [dict ExportToText];
}
-(id) UnSerialize:(NSString*) str
{
    doJsonValue* jsonvalue = [[doJsonValue alloc]init];
    [jsonvalue LoadDataFromText:str];
    return [jsonvalue GetNode];
}
#pragma mark - 注册属性（--属性定义--）
/*
 [self RegistProperty:[[doProperty alloc]init:@"属性名" :属性类型 :@"默认值" : BOOL:是否支持代码修改属性]];
 */
-(void)OnInit
{
    [super OnInit];
    if(dict==nil){
        dict = [[doJsonNode alloc]init];
    }
    //注册属性
}

//销毁所有的全局对象
-(void)Dispose
{
    //自定义的全局属性
    [dict.dictValues removeAllObjects];
    dict = nil;
}
#pragma mark -
#pragma mark - doIDataSource implements
-(doJsonValue*) GetJsonData;
{
    doJsonValue* jsonvalue = [[doJsonValue alloc]init];
    [jsonvalue SetNode:dict];
    return jsonvalue;
}

#pragma mark -
#pragma mark - 同步异步方法的实现

//同步
 - (void)addData:(NSArray *)parms
 {
     doJsonNode *_dictParas = [parms objectAtIndex:0];
     doJsonNode* datas = [_dictParas GetOneNode:@"data"];
     NSMutableDictionary* allkeyvalue = [datas GetAllKeyValues];
     for(NSString* key in allkeyvalue)
     {
         [dict SetOneValue:key :allkeyvalue[key]];
     }
     
 }
 - (void)addOne:(NSArray *)parms
 {
     doJsonNode *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSString* key = [_dictParas GetOneText:@"key" : @""];
     doJsonValue* value = [_dictParas GetOneValue:@"value"];
     [dict SetOneValue:key :value];
 }

 - (void)getCount:(NSArray *)parms
 {
     doInvokeResult *_invokeResult = [parms objectAtIndex:2];
     [_invokeResult SetResultInteger:(int)dict.dictValues.count];
 }

 - (void)getData:(NSArray *)parms
 {
     doJsonNode *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSArray* keys = [_dictParas GetOneTextArray:@"keys"];
     NSMutableArray* result = [[NSMutableArray alloc]initWithCapacity:keys.count];
     for(NSString* key in keys)
     {
        doJsonValue* _jsonValue = [dict GetOneValue:key];
        [result addObject:_jsonValue];
     }
     doInvokeResult *_invokeResult = [parms objectAtIndex:2];
     [_invokeResult SetResultArray:result ];

 }
 - (void)getOne:(NSArray *)parms
 {
     doJsonNode *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSString* key = [_dictParas GetOneText:@"key" : @""];
     doJsonValue* _jsonValue = [dict GetOneValue:key];
     doInvokeResult *_invokeResult = [parms objectAtIndex:2];
     [_invokeResult SetResultValue:_jsonValue];
 }
 - (void)removeAll:(NSArray *)parms
 {
     [dict.dictValues removeAllObjects];
     //自己的代码实现
 }
 - (void)removeData:(NSArray *)parms
 {
     doJsonNode *_dictParas = [parms objectAtIndex:0];
     NSArray* keys = [_dictParas GetOneTextArray:@"keys"];
     for(NSString* key in keys)
     {
        [dict.dictValues removeObjectForKey:key];
     }
 }
 - (void)removeOne:(NSArray *)parms
 {
     doJsonNode *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSString* key = [_dictParas GetOneText:@"key" : @""];
     if(key.length>0){
         [dict.dictValues removeObjectForKey:key];
     }
 }
 - (void)updateOne:(NSArray *)parms
 {
     doJsonNode *_dictParas = [parms objectAtIndex:0];
     //自己的代码实现
     NSString* key = [_dictParas GetOneText:@"key" : @""];
     doJsonValue* value = [_dictParas GetOneValue:@"value"];
     [dict SetOneValue:key :value];
 }
- (void)getAll:(NSArray *)parms
{
    doInvokeResult *_invokeResult = [parms objectAtIndex:2];
    [_invokeResult SetResultNode:dict];
}
//异步

@end