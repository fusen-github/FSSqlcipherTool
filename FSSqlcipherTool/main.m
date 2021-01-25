//
//  main.m
//  FSSqlcipherTool
//
//  Created by 付森 on 2021/1/22.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>
#import "NSString+Extension.h"


static void encryptFile()
{
    system("clear");
    printf("请输入加密数据库文件:\n");
    
    NSString *filePath = nil;
    
    while (true) {
        char path[1024] = "";
        scanf("%s", path);
        
        filePath = [[NSString alloc] initWithCString:path encoding:NSUTF8StringEncoding];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            printf("文件不存在在，请重新输入\n");
        }
        else
        {
            break;
        }
    }
    
    printf("请输入密码(至少6位)\n");
    
    NSString *pwd = nil;
    
    while (true) {
        char str[1024] = "";
        scanf("%s", str);
        
        pwd = [[NSString alloc] initWithCString:str encoding:NSUTF8StringEncoding];
        if (pwd.length < 6) {
            printf("密码长度必须大于6位\n");
        }
        else
        {
            break;
        }
    }
    
    NSString *oldDir = [filePath stringByDeletingLastPathComponent];
    NSString *component = [filePath lastPathComponent];
    NSString *extension = [filePath pathExtension];
    NSString *fileName = [component stringByDeletingPathExtension];
    fileName = [fileName stringByAppendingFormat:@"_encrypt"];
    
    NSString *newName = [fileName stringByAppendingPathExtension:extension];
    
    NSString *newPath = [oldDir stringByAppendingPathComponent:newName];
    
    // 指令
    NSString *cmd = [NSString stringWithFormat:@"sqlcipher %@\n", filePath];
//    int result = system(cmd.UTF8String);
    NSString *result = [cmd runAsCommand];
    
    cmd = [NSString stringWithFormat:@"ATTACH DATABASE '%@' AS encrypt KEY '%@';", newPath, pwd];
    result = [cmd runAsCommand];
    
    cmd = @"SELECT sqlcipher_export ('encrypt');";
    result = [cmd runAsCommand];
    
    cmd = @"DETACH DATABASE encrypt;";
    result = [cmd runAsCommand];

    cmd = @".q";
    result = [cmd runAsCommand];
    
    printf("加密已完成\n");
}

static void decryptFile()
{
    
}

static void runCommand()
{
    //清屏
    system("clear");
    
    while (true) {
        printf("******************************\n");
        printf("*********** 1.加密 ************\n");
        printf("*********** 2.解密 ************\n");
        printf("*********** q.退出 ************\n");
        printf("******************************\n");
        printf("请选择您的操作\n");
        char flag = '\0';
        scanf("%c", &flag);
        if (flag == '1') {
            encryptFile();
            break;
        }
        else if (flag == '2') {
            decryptFile();
        }
        else if (flag == '3') {
            printf("退出");
        }
        
    }
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        runCommand();
        
        [@"echo hello" runAsCommand];
        
        NSLog(@"结束");
        
        
//        NSString *path = @"/Users/NavInfo/Desktop/splcipher/coremap.sqlite";
//
//        NSString *aa = [path lastPathComponent];
//
//        NSString *bb = [[path pathComponents] lastObject];
//
//        NSString *cc = [path pathExtension];
//        NSString *dd = [aa stringByDeletingPathExtension];
//        NSString *ee = [dd stringByAppendingFormat:@"_enc"];
//        ee = [ee stringByAppendingPathExtension:cc];
        
        
        NSLog(@"");
    }
    return 0;
}
