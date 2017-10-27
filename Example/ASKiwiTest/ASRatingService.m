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
@property (nonatomic, strong) NSRegularExpression *regularExpression;

@end


@implementation ASRatingService

- (instancetype)init {
  if (self = [super init]) {
    self.calculator = [[ASRatingCalculator alloc] init];
    _regularExpression = [NSRegularExpression regularExpressionWithPattern:@"^\\d+((.?\\d+)|d*)$" options:NSRegularExpressionCaseInsensitive error:nil];
  }
  return self;
}

- (BOOL)inputScores:(NSString *)scoresText {
  NSArray<NSString *> *scores = [scoresText componentsSeparatedByString:@","];
  if (scores.count) {
    NSMutableArray *mScores = [[NSMutableArray alloc] init];
    for (NSString *score in scores) {
      NSRange matchRange = [_regularExpression rangeOfFirstMatchInString:score options:NSMatchingReportCompletion range:NSMakeRange(0,score.length)];
      if (!matchRange.length) {
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
  return [self.calculator average];
}

- (double)averageScoreAfterRemoveMinAndMax {
  if (!self.hasRemoveExtremum) {
    [self.calculator removeMaxAndMin];
    _hasRemoveExtremum = YES;
  }
  [[NSUserDefaults standardUserDefaults] setDouble:self.calculator.average forKey:@"asrating_lastResult"];
  return [self.calculator average];
}

- (double)lastResult {
  return [[NSUserDefaults standardUserDefaults] doubleForKey:@"asrating_lastResult"];
}
@end
