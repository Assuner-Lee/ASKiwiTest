//
//  ASRatingServiceTest.m
//  ASKiwiTest_Tests
//
//  Created by Assuner on 2017/10/18.
//  Copyright © 2017年 Assuner-Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASRatingService.h"
#import "ASRatingCalculator.h"

SPEC_BEGIN(ASRatingServiceTest)

describe(@"ASRatingServiceTest", ^{
  __block ASRatingService *ratingService;
  beforeEach(^{
    ratingService = [[ASRatingService alloc] init];
  });
  afterEach(^{
    ratingService = nil;
  });
  
  context(@"when created", ^{
    it(@"should exist", ^{
      [[ratingService shouldNot] beNil];
      [[[ratingService performSelector:@selector(calculator) withObject:nil] shouldNot] beNil];
      [[[ratingService performSelector:@selector(regularExpression) withObject:nil] shouldNot] beNil];
    });
  });
  
  context(@"when input correctly", ^{
    it(@"should return Yes", ^{
      [[theValue([ratingService inputScores:@"7.0,1,2,3"]) should] beYes];
      [[theValue([ratingService inputScores:@"1,2,3,4/7.0"]) should] beNo];
      [[theValue([ratingService inputScores:@"1,2,3/4,s"]) should] beNo];
      [[theValue([ratingService inputScores:@"1,2,3 ,5,8"]) should] beNo];
      [[theValue([ratingService inputScores:@"-1,2,3,5,8"]) should] beNo];
    });
    
    it(@"can return correct average and record", ^{
      id mock = [ASRatingCalculator mock];
      [ratingService stub:@selector(calculator) andReturn:mock withArguments:nil];
      KWCaptureSpy *spy = [mock captureArgument:@selector(inputScores:) atIndex:0];
      [[theValue([ratingService inputScores:@"7.5,9.6,6.2,9"]) should] beYes];
      [[spy.argument shouldNot] beNil];
      
      [mock stub:@selector(average) andReturn:theValue(8.07) withArguments:nil];
      [[theValue([ratingService averageScore]) should] equal:8.07 withDelta:0.01];
      [[theValue([ratingService lastResult]) should] equal:8.07 withDelta:0.01];
      
      [mock stub:@selector(average) andReturn:theValue(8.25) withArguments:nil];
      [mock stub:@selector(removeMaxAndMin)];
      [[theValue([ratingService averageScoreAfterRemoveMinAndMax]) should] equal:8.25 withDelta:0.01];
      [[expectFutureValue(theValue([ratingService lastResult])) shouldEventuallyBeforeTimingOutAfter(3)] beNonNil];
    });
  });
});

SPEC_END
