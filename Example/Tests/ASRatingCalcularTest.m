//
//  ASRatingServiceTest.m
//  ASKiwiTest_Tests
//
//  Created by Assuner on 2017/10/18.
//  Copyright © 2017年 Assuner-Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASRatingCalculator.h"

SPEC_BEGIN(ASRatingCalculatorTest)

describe(@"ASRatingCalculatorTest", ^{
  __block ASRatingCalculator *calculator;
  beforeEach(^{
    calculator = [[ASRatingCalculator alloc] init];
  });
  afterEach(^{
    calculator = nil;
  });
  
  context(@"when created", ^{
    it(@"should exist", ^{
      [[calculator shouldNot] beNil];
      [[calculator.scores shouldNot] beNil];
    });
  });
  
  context(@"when input correctly", ^{
    beforeEach(^{
      [calculator inputScores:@[@3, @2, @1, @4, @8.5, @5.5]];
      [[calculator.scores should] haveCountOf:6];
    });
    
    it(@"should have scores", ^{
      [calculator inputScores:@[@4, @3, @2, @1]];
      [[theValue(calculator.scores.count) should] equal:theValue(4)];
      
      [[theBlock(^{
        [calculator inputScores:@[@4, @3, @"ss", @"5"]];
      }) should] raiseWithName:@"ASRatingCalculatorInputError"];
    });
    
    it(@"return average correctly", ^{
      [[theValue([calculator average]) should] equal:theValue(4.0)];
      
      [calculator inputScores:@[@100, @111.5, @46]];
      [[theValue([calculator average]) should] equal:85.83 withDelta:0.01];
    });
    
    it(@"can sort correctly", ^{
      [[theValue([calculator minScore]) should] equal:@1.0];
      [[theValue([calculator maxScore]) should] equal:@8.5];
      [[theValue([calculator average]) should] equal:theValue(4)];
    });

    it(@"can remove max and min correctly", ^{
      [calculator removeMaxAndMin];
      [[theValue([calculator minScore]) should] equal:@2.0];
      [[theValue([calculator maxScore]) should] equal:theValue(5.5)];
      [[theValue([calculator average]) should] equal:3.6 withDelta:0.1];
      
      [calculator inputScores:@[@3]];
      [calculator removeMaxAndMin];
      [[theValue([calculator minScore]) should] equal:@3.0];
      [[theValue([calculator maxScore]) should] equal:theValue(3)];
      [[theValue([calculator average]) should] equal:3 withDelta:0.1];
    });
  });
});

SPEC_END

