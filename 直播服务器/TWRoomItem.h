//
//  TWRoomItem.h
//  直播服务器
//
//  Created by 耐克了解了 on 13/7/17.
//  Copyright © 2017年 耐克了解了. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWRoomItem : NSObject
{
    int _age;
}

@property (nonatomic,assign) NSInteger roomID;

@property (nonatomic,copy) NSString *roomName;

+ (instancetype)room;

@end
