//
//  NSString+Extension.m
//  FSSqlcipherTool
//
//  Created by 付森 on 2021/1/22.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)runAsCommand
{
    NSPipe* pipe = [NSPipe pipe];

    NSTask* task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    [task setArguments:@[@"-c", [NSString stringWithFormat:@"%@", self]]];
    [task setStandardOutput:pipe];

    NSFileHandle* file = [pipe fileHandleForReading];
    [task launch];

    return [[NSString alloc] initWithData:[file readDataToEndOfFile] encoding:NSUTF8StringEncoding];
}

@end

/*
 新建一个文本,输入要执行的终端命令,然后另存为无格式文件, 比如另存为名script.

 然后打开终端,输入 sudo chmod u+x script 这个script要写成那个文件的绝对路径.

 比如 sudo chmod u+x /Users/xxx/Desktop/script

 执行后,那个script文件就会变成类似批处理的文件.双击就能运行里面的终端命令.
 */

