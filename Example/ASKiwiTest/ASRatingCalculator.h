//
//  ASRatingCalculator.h
//  ASKiwiTest_Example
//
//  Created by Assuner on 2017/10/13.
//  Copyright © 2017年 Assuner-Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef double ASScore;

@interface ASRatingCalculator : NSObject

@property (nonatomic, strong, readonly) NSArray *scores;

- (void)inputScores:(NSArray<NSNumber *> *)scores;
- (void)removeMaxAndMin;
- (ASScore)maxScore;
- (ASScore)minScore;
- (ASScore)average;

@end
