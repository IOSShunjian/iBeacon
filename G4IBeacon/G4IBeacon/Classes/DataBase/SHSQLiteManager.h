//
//  SHSQLiteManager.h
//  G4Image
//
//  Created by LHY on 2017/4/11.
//  Copyright © 2017年 SmartHomeGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "SHIBeacon.h"

@interface SHSQLiteManager : NSObject


/// 获得最大的iBeaconID
- (NSUInteger)getMaxiBeaconID;

/// 插入一个新的iBeacon
- (BOOL)insert:(SHIBeacon *)iBeacon;

SingletonInterface(SHSQLiteManager)

@end
