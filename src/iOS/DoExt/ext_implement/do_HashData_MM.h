//
//  do_HashData_MM.h
//  DoExt_MM
//
//  Created by @userName on @time.
//  Copyright (c) 2015年 DoExt. All rights reserved.
//

#import "do_HashData_IMM.h"
#import "doMultitonModule.h"
#import "doIDataSource.h"

@interface do_HashData_MM : doMultitonModule<do_HashData_IMM,doIDataSource>

@end
