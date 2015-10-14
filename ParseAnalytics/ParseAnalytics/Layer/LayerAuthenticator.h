//
//  LayerAuthenticator.h
//  ParseAnalytics
//
//  Created by Nick Kibish on 13.10.15.
//  Copyright © 2015 Nick Kibish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LayerKit/LayerKit.h>

@interface LayerAuthenticator : NSObject
@property (nonatomic) LYRClient *layerClient;

- (BOOL)authenticate;

@end
