//
//  ASRatingCalculator.m
//  ASKiwiTest_Example
//
//  Created by Assuner on 2017/10/13.
//  Copyright © 2017年 Assuner-Lee. All rights reserved.
//

#import "ASRatingCalculator.h"

@interface ASRatingCalculator ()

@property (nonatomic, strong) NSMutableArray *mScores;

@end


@implementation ASRatingCalculator

- (instancetype)init {
  if (self = [super init]) {
    self.mScores = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NSArray *)scores {
  return [self.mScores copy];
}

- (void)inputScores:(NSArray<NSNumber *> *)scores {
  if (scores.count) {
    Class class = NSClassFromString(@"__NSCFNumber");
    for (NSNumber *score in scores) {
      if (![score isKindOfClass:class] && [score doubleValue] >= 0.0f) {
        [NSException raise:@"ASRatingCalculatorInputError" format:@"input contains non-numberic object"];
        return;
      }
    }
    [self.mScores removeAllObjects];
    [self.mScores addObjectsFromArray:scores];
  }
}

- (ASScore)minScore {
  if (self.mScores.count) {
    [self sortScoresAscending];
    return [[self.mScores firstObject] doubleValue];
  }
  return 0.0f;
}

- (ASScore)maxScore {
  if (self.mScores.count) {
    [self sortScoresAscending];
    return [[self.mScores lastObject] doubleValue];
  }
  return 0.0f;
}

- (void)removeMaxAndMin {
  if (self.mScores.count > 1) {
    [self sortScoresAscending];
    [self.mScores removeObjectAtIndex:0];
    [self.mScores removeLastObject];
  }
}

- (ASScore)average {
  if (self.mScores.count > 0) {
    ASScore sum = 0.0;
    for (NSNumber *score in self.mScores) {
      sum += score.doubleValue;
    }
    return sum / self.mScores.count;
  }
  return 0;
}

#pragma - Private
  
- (void)sortScoresAscending {
  if (self.mScores.count) {
    [self.mScores sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
      return [obj1 compare:obj2];
    }];
  }
}
  
@end
