/**
 *	Created by kimziv on 13-9-14.
 */
#ifndef _HanyuPinyinOutputFormat_H_
#define _HanyuPinyinOutputFormat_H_

typedef NS_ENUM(NSInteger, BFToneType) {
  BFToneTypeWithToneNumber,
  BFToneTypeWithoutTone,
  BFToneTypeWithToneMark
};

typedef NS_ENUM(NSInteger, BFCaseType) {
    BFCaseTypeUppercase,
    BFCaseTypeLowercase
};

typedef NS_ENUM(NSInteger, BFVCharType) {
    BFVCharTypeWithUAndColon,
    BFVCharTypeWithV,
    BFVCharTypeWithUUnicode
};


@interface BFHanyuPinyinOutputFormat : NSObject

@property(nonatomic, assign) BFVCharType vCharType;
@property(nonatomic, assign) BFCaseType caseType;
@property(nonatomic, assign) BFToneType toneType;

- (id)init;
- (void)restoreDefault;
@end

#endif // _HanyuPinyinOutputFormat_H_
