//
//  ASRatingService.h
//  ASKiwiTest_Example
//
//  Created by Assuner on 2017/10/18.
//  Copyright © 2017年 Assuner-Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASRatingService : NSObject

- (BOOL)inputScores:(NSString *)scoresText;
- (double)averageScore;
- (double)averageScoreAfterRemoveMinAndMax;
- (double)lastResult;
@end
