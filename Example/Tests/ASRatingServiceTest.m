//
//  ASRatingServiceTest.m
//  ASKiwiTest_Tests
//
//  Created by Assuner on 2017/10/18.
//  Copyright © 2017年 Assuner-Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASRatingService.h"

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
    });
  });
});

SPEC_END
