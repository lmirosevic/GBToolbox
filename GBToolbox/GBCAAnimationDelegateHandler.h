//
//  GBCAAnimationDelegateHandler.h
//  GBToolbox
//
//  Created by Luka Mirosevic on 16/09/2016.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef void(^GBCAAnimationDidStartBlock)(CAAnimation * _Nonnull animation);
typedef void(^GBCAAnimationDidStopBlock)(CAAnimation * _Nonnull animation, BOOL finished);

@interface GBCAAnimationDelegateHandler : NSObject <CAAnimationDelegate>

+ (nonnull instancetype)delegateWithDidStart:(nullable GBCAAnimationDidStartBlock)didStart didStop:(nullable GBCAAnimationDidStopBlock)didStop;

@end

@interface GBCAAnimationDelegateHandler ()

@property (copy, nonatomic, nullable) GBCAAnimationDidStartBlock  didStart;
@property (copy, nonatomic, nullable) GBCAAnimationDidStopBlock   didStop;

@end
