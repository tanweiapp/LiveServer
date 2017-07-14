//
//  ViewController.m
//  直播服务器
//
//  Created by 耐克了解了 on 13/7/17.
//  Copyright © 2017年 耐克了解了. All rights reserved.
//

#import "ViewController.h"
#import "TWRoomItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <objc/message.h>

@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *rooms;

@end
/*
  GET:
  route:/CreateRoom
 
  params:
  roomID
  roomName
 
 */

@implementation ViewController

- (void)testModel
{
      TWRoomItem *room = [TWRoomItem room];

    
    /*
     runTime : 获取一个类中所以属性()
     NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
     dicM[roomID] =[room valueForKeyPath:roomID]
     dicM[roomName] =[room valueForKeyPath:roomName]
     
     */
      int arr[] = {1,2,3};
    int a = arr[0];
    
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    
    //获取当前类的成员变量
    int count = 0;
    Ivar *ivarList = class_copyIvarList([TWRoomItem class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        ivarName = [ivarName substringFromIndex:1];
        id value = [room valueForKeyPath:ivarName];
        
        if (value) {
            dicM[ivarName] = value;
        }
        
        NSLog(@"%@",ivarName);
    }
    
    //判断有没有父类
    Class superClass = class_getSuperclass([TWRoomItem class]);
    
    NSString *superClassName = NSStringFromClass(superClass);
}

- (IBAction)createRoom:(UIBarButtonItem *)sender {
    
    //创建房间模型
    TWRoomItem *room = [TWRoomItem room];
    //room.rommName = @"337Room";
    
    //判断房间名是否重名(后端)
    //保存到服务器，发送请求
   [[AFHTTPSessionManager manager]GET:@"http://192.168.1.114:8080/CreateRoom" parameters:room.mj_keyValues progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       //获取创建房间结果
       
       NSLog(@"%@",responseObject[@"isRepetition"]);
       
       BOOL isRepetition = [responseObject[@"isRepetition"] boolValue];
       if (!isRepetition) {
           NSLog(@"房间创建成功！");
           //成功，保存房间模型
            [self.rooms addObject:room];
           //刷新表格!
           [self.tableView reloadData];
          
       }
       
       NSLog(@"JSON_DATA:%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===error:%@",error);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    [self tw_getRoomList];
}

- (void)tw_getRoomList
{
    [[AFHTTPSessionManager manager]GET:@"http://192.168.1.114:8080/RoomList" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取创建房间结果
           NSLog(@"self.rooms:%@",responseObject);
        
        self.rooms = [TWRoomItem mj_objectArrayWithKeyValuesArray:responseObject];
            //刷新表格!
            [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===error:%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    TWRoomItem *room = self.rooms[indexPath.row];
    cell.textLabel.text = room.roomName;
    
    return cell;
}



#pragma mark - getter
- (NSMutableArray *)rooms
{
    if (_rooms == nil) {
        _rooms = [NSMutableArray array];
    }
    return _rooms;
}


@end
