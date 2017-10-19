//
//  ASKiwiTestTests.m
//  ASKiwiTestTests
//
//  Created by Assuner-Lee on 10/09/2017.
//  Copyright (c) 2017 Assuner-Lee. All rights reserved.
//

// https://github.com/kiwi-bdd/Kiwi

SPEC_BEGIN(InitialTests)

describe(@"My initial tests1", ^{
  
  context(@"will pass", ^{
    
    it(@"can do maths", ^{
      [[@23 should] beGreaterThan:@1];
    });
    
    it(@"can read", ^{
      [[@"team" should] containString:@"t"];
    });
  });
});
describe(@"My initial tests2", ^{

  context(@"will fail", ^{

      it(@"can do maths", ^{
          [[@1 should] equal:@2];
      });

      it(@"can read", ^{
          [[@"number" should] equal:@"string"];
      });
    
      it(@"will wait and fail", ^{
          NSObject *object = [[NSObject alloc] init];
          [[expectFutureValue(object) shouldEventually] receive:@selector(autoContentAccessingProxy)];
      });
  });

  context(@"will pass", ^{
    
      it(@"can do maths", ^{
        [[@1 should] beLessThan:@23];
      });
    
      it(@"can read", ^{
          [[@"team" shouldNot] containString:@"I"];
      });  
  });
  
});



SPEC_END

