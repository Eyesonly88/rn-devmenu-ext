//
//  CustomDevMenuModule.m
//  rnDevMenuExt
//
//  Created by guy blank on 10/5/17.
//

#import <Foundation/Foundation.h>
#import "CustomDevMenuModule.h"

@implementation CustomDevMenuModule

@synthesize bridge = _bridge;

#if __has_include(<React/RCTDevMenu.h>)

RCTDevMenuItem *_devMenuItem;

#endif

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

- (instancetype)init
{
  // We're only overriding this to ensure the module gets created at startup
  // TODO (t11106126): Remove once we have more declarative control over module setup.
  return [super init];
}

- (void)setBridge:(RCTBridge *)bridge
{
  _bridge = bridge;
#if __has_include(<React/RCTDevMenu.h>)
  [_bridge.devMenu addItem:self.devMenuItem];
#endif
}

#if __has_include(<React/RCTDevMenu.h>)

- (RCTDevMenuItem *)devMenuItem
{
  if (!_devMenuItem) {
    _devMenuItem =
    [RCTDevMenuItem buttonItemWithTitleBlock:^NSString *{
      return @"My Test";
    } handler:^{
      NSLog(@"My Test Clicked!");
      [[NSNotificationCenter defaultCenter] postNotificationName:@"toggleTestView" object:nil];
    }];
  }
  return _devMenuItem;
}

#endif

@end
