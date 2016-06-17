//
//  Constant.h
//  today
//
//  Created by ervinchen on 16/6/17.
//  Copyright © 2016年 ccnyou. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define USING_DEBUG_ENVIRONMENT 1

#define DEBUG_SERVER_URL    @"https://raw.githubusercontent.com/ccnyou/ccnyou.github.com/master/apps/today/debug"
#define RELEASE_SERVER_URL  @"https://raw.githubusercontent.com/ccnyou/ccnyou.github.com/master/apps/today/release"
#if USING_DEBUG_ENVIRONMENT
#define SERVER_URL DEBUG_SERVER_URL
#else
#define SERVER_URL RELEASE_SERVER_URL
#endif

#endif /* Constant_h */
