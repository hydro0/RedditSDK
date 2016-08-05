//
//  RSConfigurationValidator.h
//  RedditSDK
//
//  Created by Orest Savchak on 8/4/16.
//  Copyright © 2016 Orest Savchak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSearchConfiguration.h"

@interface RSConfigurationValidator : NSObject

+ (BOOL)validateConfiguration:(RSSearchConfiguration *)configuration withError:(NSError **)error;

@end
