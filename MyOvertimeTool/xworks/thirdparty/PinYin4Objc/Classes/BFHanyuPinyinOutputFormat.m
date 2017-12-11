//
//  
//
//  Created by kimziv on 13-9-14.
//

#include "BFHanyuPinyinOutputFormat.h"

@implementation BFHanyuPinyinOutputFormat
@synthesize vCharType=_vCharType;
@synthesize caseType=_caseType;
@synthesize toneType=_toneType;

- (id)init {
  if (self = [super init]) {
    [self restoreDefault];
  }
  return self;
}

- (void)restoreDefault {
    _vCharType = BFVCharTypeWithUAndColon;
    _caseType = BFCaseTypeLowercase;
    _toneType = BFToneTypeWithToneNumber;
}

@end
