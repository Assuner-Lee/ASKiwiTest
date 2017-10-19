//
//  ASRatingService.m
//  ASKiwiTest_Example
//
//  Created by Assuner on 2017/10/18.
//  Copyright © 2017年 Assuner-Lee. All rights reserved.
//

#import "ASRatingService.h"
#import "ASRatingCalculator.h"

@interface ASRatingService ()

@property (nonatomic, strong) ASRatingCalculator *calculator;
@property (nonatomic, assign) BOOL hasRemoveExtremum;

@end


@implementation ASRatingService

- (instancetype)init {
  if (self = [super init]) {
    self.calculator = [[ASRatingCalculator alloc] init];
  }
  return self;
}

- (BOOL)inputScores:(NSString *)scoresText {
  NSArray<NSString *> *scores = [scoresText componentsSeparatedByString:@","];
  if (scores.count) {
    NSMutableArray *mScores = [[NSMutableArray alloc] init];
    for (NSString *score in scores) {
      if (![[@(score.doubleValue) stringValue] isEqualToString:score]) {
        return NO;
      }
      [mScores addObject:@(score.doubleValue)];
    }
    [self.calculator inputScores:mScores];
    return YES;
  }
  return NO;
}

- (double)averageScore {
  [[NSUserDefaults standardUserDefaults] setDouble:self.calculator.average forKey:@"asrating_lastResult"];
  return self.calculator.average;
}

- (double)averageScoreAfterRemoveMinAndMax {
  if (!self.hasRemoveExtremum) {
    [self.calculator removeMaxAndMin];
    _hasRemoveExtremum = YES;
  }
  return self.calculator.average;
}

- (double)lastResult {
  return [[NSUserDefaults standardUserDefaults] doubleForKey:@"asrating_lastResult"];
}
@end
