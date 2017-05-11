//
//  PrintLog.h
//  百思不得姐
//
//  Created by LHY on 2017/3/8.
//  Copyright © 2017年 LHY. All rights reserved.
//

#ifndef PrintLog_h
#define PrintLog_h


#ifdef DEBUG
# define SHLog(fmt, ...) NSLog((@"[文件位置: %s]\n" "[类名与方法: %s]\n" "[行号: %d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define SHLog(...)
#endif


#endif /* PrintLog_h */
