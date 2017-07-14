//
//  TWRoomItem.m
//  直播服务器
//
//  Created by 耐克了解了 on 13/7/17.
//  Copyright © 2017年 耐克了解了. All rights reserved.
//

#import "TWRoomItem.h"

@implementation TWRoomItem
+ (instancetype)room
{
    TWRoomItem *item = [[self alloc]init];
    item.roomID =arc4random() % 1000;
    
    item.roomName = [NSString stringWithFormat:@"%ldRoom",item.roomID];
    
    return item;
}


@end
