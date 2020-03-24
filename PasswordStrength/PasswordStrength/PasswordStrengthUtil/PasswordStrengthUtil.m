//
//  PasswordStrengthUtil.m
//  Driver-ios
//
//  Created by Edward on 2020/2/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "PasswordStrengthUtil.h"

@interface PasswordStrengthUtil ()

@property (nonatomic, strong) NSString *sAlphas;
@property (nonatomic, strong) NSString *sNumerics;
@property (nonatomic, strong) NSString *sSymbols;

@property (nonatomic, assign) int nMultRepChar, nMultConsecSymbol;
@property (nonatomic, assign) int nMultMidChar, nMultRequirements, nMultConsecAlphaUC, nMultConsecAlphaLC, nMultConsecNumber;
@property (nonatomic, assign) int nReqCharType, nMultAlphaUC, nMultAlphaLC, nMultSeqAlpha, nMultSeqNumber, nMultSeqSymbol;
@property (nonatomic, assign) int nMultLength, nMultNumber;
@property (nonatomic, assign) int nMultSymbol;

@property (nonatomic, assign) int nScore, nLength, nAlphaUC, nAlphaLC, nNumber, nSymbol, nMidChar, nRequirements, nAlphasOnly, nNumbersOnly, nUnqChar, nRepChar, nConsecAlphaUC, nConsecAlphaLC, nConsecNumber, nConsecSymbol, nConsecCharType, nSeqAlpha, nSeqNumber, nSeqSymbol,nSeqChar, nReqChar, nMultConsecCharType;

@property (nonatomic, assign) double nRepInc;

@property (nonatomic, assign) int nTmpAlphaUC,nTmpAlphaLC, nTmpNumber,nTmpSymbol;
@property (nonatomic, strong) NSString *sComplexity;
@property (nonatomic, strong) NSString *sStandards;
@property (nonatomic, assign) int nMinPwdLen;

@property (nonatomic, assign) int lengthScore;
@property (nonatomic, assign) int upperScore;
@property (nonatomic, assign) int lowerScore;
@property (nonatomic, assign) int numScore;
@property (nonatomic, assign) int speCharScore;
@property (nonatomic, assign) int midCharScore;
@property (nonatomic, assign) int minScore;
@property (nonatomic, assign) int onlyAlpScore;
@property (nonatomic, assign) int onlyNumScore;
@property (nonatomic, assign) int repCharScore;
@property (nonatomic, assign) int seqUpperScore;
@property (nonatomic, assign) int seqLowerScore;
@property (nonatomic, assign) int seqNumScore;
@property (nonatomic, assign) int seq3WordScore;
@property (nonatomic, assign) int seq3NumScore;
@property (nonatomic, assign) int seq3sepScore;


@end

@implementation PasswordStrengthUtil

+ (instancetype)sharedInstance {
    
    static PasswordStrengthUtil *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[PasswordStrengthUtil alloc] init];
    });
    return _sharedInstance;
}

- (NSInteger)passwordStrengthWith:(NSString *)password {
    
    _sAlphas   = @"abcdefghijklmnopqrstuvwxyz";//26位
    _sNumerics = @"01234567890";//11
    _sSymbols  = @"~!@#$%^&*()";//11
    
    _lengthScore   = 0;
    _upperScore    = 0;
    _lowerScore    = 0;
    _numScore      = 0;
    _speCharScore  = 0;
    _midCharScore  = 0;
    _minScore      = 0;
    _onlyAlpScore  = 0;
    _onlyNumScore  = 0;
    _repCharScore  = 0;
    _seqUpperScore = 0;
    _seqLowerScore = 0;
    _seqNumScore   = 0;
    _seq3WordScore = 0;
    _seq3NumScore  = 0;
    _seq3sepScore  = 0;
    
    _nMultRepChar       = 1;
    _nMultConsecSymbol  = 1;
    _nMultMidChar       = 2;
    _nMultRequirements  = 2;
    _nMultConsecAlphaUC = 2;
    _nMultConsecAlphaLC = 2;
    _nMultConsecNumber  = 2;
    _nReqCharType       = 3;
    _nMultAlphaUC       = 3;
    _nMultAlphaLC       = 3;
    _nMultSeqAlpha      = 3;
    _nMultSeqNumber     = 3;
    _nMultSeqSymbol     = 3;
    _nMultLength        = 4;
    _nMultNumber        = 4;
    _nMultSymbol        = 6;
    
    _nTmpAlphaUC = -1;
    _nTmpAlphaLC = -1;
    _nTmpNumber  = -1;
    _nTmpSymbol  = -1;

    _nScore              = 0;
    _nLength             = 0;
    _nAlphaUC            = 0;
    _nAlphaLC            = 0;
    _nNumber             = 0;
    _nSymbol             = 0;
    _nMidChar            = 0;
    _nRequirements       = 0;
    _nAlphasOnly         = 0;
    _nNumbersOnly        = 0;
    _nUnqChar            = 0;
    _nRepChar            = 0;
    _nConsecAlphaUC      = 0;
    _nConsecAlphaLC      = 0;
    _nConsecNumber       = 0;
    _nConsecSymbol       = 0;
    _nConsecCharType     = 0;
    _nSeqAlpha           = 0;
    _nSeqNumber          = 0;
    _nSeqSymbol          = 0;
    _nSeqChar            = 0;
    _nReqChar            = 0;
    _nMultConsecCharType = 0;
    
    _nRepInc = .0f;
    _nMinPwdLen = 8;
    
    
    if (password.length > 0) {
        
        _nScore = (int)(password.length*_nMultLength);
        
        //密码长度分数
        _lengthScore = (int)(password.length*_nMultLength);
        
        _nLength = (int)password.length;
        
        int arrPwdLen = (int)password.length;
        
        /* Loop through password to check for Symbol, Numeric, Lowercase and Uppercase pattern matches */
        for (int a = 0; a < arrPwdLen; a++) {
            
            NSString *arrPwd = [password substringWithRange:NSMakeRange(a, 1)];
            
            if ([self containA_Z:arrPwd]) {
                if (_nTmpAlphaUC != -1) {
                    if (_nTmpAlphaUC + 1 == a) {
                        _nConsecAlphaUC++;
                        _nConsecCharType++;
                    }
                }
                _nTmpAlphaUC = a;
                _nAlphaUC++;
            } else if ([self containa_z:arrPwd]) {
                if (_nTmpAlphaLC != -1) {
                    if (_nTmpAlphaLC + 1 == a) {
                        _nConsecAlphaLC++;
                        _nConsecCharType++;
                    }
                }
                _nTmpAlphaLC = a;
                _nAlphaLC++;
            } else if ([self contain0_9:arrPwd]) {
                if (a > 0 && a < (arrPwdLen - 1)) {
                    _nMidChar++;
                }
                if (_nTmpNumber != -1) {
                    if (_nTmpNumber + 1 == a) {
                        _nConsecNumber++;
                        _nConsecCharType++;
                    }
                }
                _nTmpNumber = a;
                _nNumber++;
            } else if ([self containOther:arrPwd]) {
                if (a > 0 && a < (arrPwdLen - 1)) {
                    _nMidChar++;
                }
                if (_nTmpSymbol != -1) {
                    if (_nTmpSymbol + 1 == a) {
                        _nConsecSymbol++;
                        _nConsecCharType++;
                    }
                }
                _nTmpSymbol = a;
                _nSymbol++;
            }
            
            /* Internal loop through password to check for repeat characters */
            BOOL bCharExists = false;
            for (int b = 0; b < arrPwdLen; b++) {
                NSString *arrPwdb = [password substringWithRange:NSMakeRange(b, 1)];
                if ([arrPwd isEqualToString:arrPwdb] && a != b) {
                    /* repeat character exists */
                    bCharExists = true;
                    /*
                     Calculate icrement deduction based on proximity to identical characters
                     Deduction is incremented each time a new match is discovered
                     Deduction amount is based on total password length divided by the
                     difference of distance between currently selected match
                     */
                    _nRepInc += fabs((arrPwdLen * 1.0)/(b - a));
                }
            }
            if (bCharExists) {
                _nRepChar++;
                _nUnqChar = arrPwdLen - _nRepChar;
                _nRepInc = (_nUnqChar != 0) ? ceil(_nRepInc / _nUnqChar) : ceil(_nRepInc);
            }
        }
        
        /* Check for sequential alpha string patterns (forward and reverse) */
        // 连续字母
        for (int s = 0; s < 23; s++) {
            
            NSString *sFwd = [_sAlphas substringWithRange:NSMakeRange(s, 3)];
            NSString *sRev = [self reverse:sFwd];
            NSString *lowerStr = [password lowercaseString];
            
            if ([lowerStr containsString:sFwd] || [lowerStr containsString:sRev]) {
                _nSeqAlpha++;
                _nSeqChar++;
            }
        }
        
        /* Check for sequential numeric string patterns (forward and reverse) */
        for (int s = 0; s < 8; s++) {
            NSString *sFwd = [_sNumerics substringWithRange:NSMakeRange(s, 3)];
            NSString *sRev = [self reverse:sFwd];
            NSString *lowerStr = [password lowercaseString];
            if ([lowerStr containsString:sFwd] || [lowerStr containsString:sRev]) {
                _nSeqNumber++;
                _nSeqChar++;
            }
        }
        
        /* Check for sequential symbol string patterns (forward and reverse) */
        for (int s = 0; s < 8; s++) {
            NSString *sFwd = [_sSymbols substringWithRange:NSMakeRange(s, 3)];
            NSString *sRev = [self reverse:sFwd];
            NSString *lowerStr = [password lowercaseString];
            if ([lowerStr containsString:sFwd] || [lowerStr containsString:sRev]) {
                _nSeqSymbol++;
                _nSeqChar++;
            }
        }
        
        /* Modify overall score value based on usage vs requirements */
        /* General point assignment */
        // 加分项
        if (_nAlphaUC > 0 && _nAlphaUC < _nLength) {
            //大写字母
            int tempScore = (_nLength - _nAlphaUC) * 2;
            _nScore = _nScore + tempScore;
            _upperScore = tempScore;
        }
        if (_nAlphaLC > 0 && _nAlphaLC < _nLength) {
            int tempScore = (_nLength - _nAlphaLC) * 2;
            //小写字母
            _nScore = _nScore + tempScore;
            _lowerScore = tempScore;
            
        }
        if (_nNumber > 0 && _nNumber < _nLength) {
            //数字字符
            int tempScore = (_nNumber * _nMultNumber);
            _nScore = _nScore + tempScore;
            _numScore = tempScore;
        }
        if (_nSymbol > 0) {
            //特殊符号
            int tempScore = (_nSymbol * _nMultSymbol);
            _nScore = _nScore + tempScore;
            _speCharScore = tempScore;
        }
        if (_nMidChar > 0) {
            //密码中间包含该数字或特殊符号
            int tempScore = (_nMidChar * _nMultMidChar);
            _nScore = _nScore + tempScore;
            _midCharScore = tempScore;
        }
        
        // 扣分项
        /* Point deductions for poor practices */
        if ((_nAlphaLC > 0 || _nAlphaUC > 0) && _nSymbol == 0 && _nNumber == 0) {  // Only Letters
            // 只有大小写字母
            _nScore = _nScore - _nLength;
            _nAlphasOnly = _nLength;
            _onlyAlpScore = -_nLength;
        }
        if (_nAlphaLC == 0 && _nAlphaUC == 0 && _nSymbol == 0 && _nNumber > 0) {  // Only Numbers
            // 只有数字
            _nScore = _nScore - _nLength;
            _nNumbersOnly = _nLength;
            _onlyNumScore = -_nLength;
        }
        if (_nRepChar > 0) {  // Same character exists more than once
            // 重复字符
            _nScore = _nScore - _nRepInc;
            _repCharScore = -_nRepInc;
        }
        if (_nConsecAlphaUC > 0) {  // Consecutive Uppercase Letters exist
            // 连续大写字母
            int tempScore = _nConsecAlphaUC * _nMultConsecAlphaUC;
            _nScore = _nScore - tempScore;
            _seqUpperScore = -tempScore;
        }
        if (_nConsecAlphaLC > 0) {  // Consecutive Lowercase Letters exist
            int tempScore = _nConsecAlphaLC * _nMultConsecAlphaLC;
            // 连续小写字母
            _nScore = _nScore - tempScore;
            _seqLowerScore = -tempScore;
        }
        if (_nConsecNumber > 0) {  // Consecutive Numbers exist
            int tempScore = _nConsecNumber * _nMultConsecNumber;
            // 连续数字
            _nScore = _nScore - tempScore;
            _seqNumScore = -tempScore;
        }
        if (_nSeqAlpha > 0) {  // Sequential alpha strings exist (3 characters or more)
            int tempScore = (_nSeqAlpha * _nMultSeqAlpha);
            // 超过三个连续字母(如abc,def,hij)
            _nScore = _nScore - tempScore;
            _seq3WordScore = -tempScore;
        }
        if (_nSeqNumber > 0) {  // Sequential numeric strings exist (3 characters or more)
            int tempScore = (_nSeqNumber * _nMultSeqNumber);
            //      超过三个连续数字(如123，567)
            _nScore = _nScore - tempScore;
            _seq3NumScore = -tempScore;
        }
        if (_nSeqSymbol > 0) {  // Sequential symbol strings exist (3 characters or more)
            int tempScore = (_nSeqSymbol * _nMultSeqSymbol);
            //     超过三个连续特殊字符(如!@#,^&*)
            _nScore = _nScore - tempScore;
            _seq3sepScore = -tempScore;
        }
        
        /* Determine if mandatory requirements have been met and set image indicators accordingly */
        NSArray *arrChars = @[@(_nLength), @(_nAlphaUC),@(_nAlphaLC), @(_nNumber), @(_nSymbol)];
        NSArray *arrCharsIds = @[@"nLength", @"nAlphaUC", @"nAlphaLC", @"nNumber", @"nSymbol"];
        int arrCharsLen = (int)arrChars.count;
        for (int c = 0; c < arrCharsLen; c++) {
            int minVal;
            if ([arrCharsIds[c] isEqualToString:@"nLength"]) {
                minVal = _nMinPwdLen - 1;
            } else {
                minVal = 0;
            }
            if ([arrChars[c] intValue] == minVal + 1) {
                _nReqChar++;
            } else if ([arrChars[c] intValue] > minVal + 1) {
                _nReqChar++;
            } else {
            }
        }
        _nRequirements = _nReqChar;
        
        
        int nMinReqChars = 0;
        if (password.length >= _nMinPwdLen) {
            nMinReqChars = 3;
        } else {
            nMinReqChars = 4;
        }
        
        if (_nRequirements > nMinReqChars) {  // One or more required characters exist
            int tempScore = _nRequirements * 2;
            _nScore = _nScore + tempScore;
            // 已达到最低要求项目
            _minScore = tempScore;
        }
        
        /* Determine complexity based on overall score */
        if (_nScore > 100) {
            _nScore = 100;
        } else if (_nScore < 0) {
            _nScore = 0;
        }
             
    }
    
    NSLog(@"\n\n\n********************************************************************");
    NSLog(@"密码长度 %d",_lengthScore);
    NSLog(@"大写字母 %d",_upperScore);
    NSLog(@"小写字母 %d",_lowerScore);
    NSLog(@"数字 %d",_numScore);
    NSLog(@"特殊符号 %d",_speCharScore);
    NSLog(@"密码中间包含该数字或特殊符号 %d",_midCharScore);
    NSLog(@"已达到最低要求项目 %d",_minScore);
    NSLog(@"只有大小写字母 %d",_onlyAlpScore);
    NSLog(@"只有数字 %d",_onlyNumScore);
    NSLog(@"重复字符 (区分大小写) %d",_repCharScore);
    NSLog(@"连续大写字母 %d",_seqUpperScore);
    NSLog(@"连续小写字母 %d",_seqLowerScore);
    NSLog(@"连续数字 %d",_seqNumScore);
    NSLog(@"超过三个连续字母(如abc,def,hij) %d",_seq3WordScore);
    NSLog(@"超过三个连续数字(如123，567) %d",_seq3NumScore);
    NSLog(@"过三个连续特殊字符(如!@#,^&*) %d",_seq3sepScore);
    NSLog(@"总分 %d",_nScore);
    NSLog(@"==================================================================\n\n\n");
    return _nScore;
}

#pragma mark - Helper
- (NSString *)reverse:(NSString *)oldStr {
    
    NSMutableString *newStr = [NSMutableString stringWithCapacity:oldStr.length];
    
    [oldStr enumerateSubstringsInRange:NSMakeRange(0, oldStr.length) options:NSStringEnumerationReverse|NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [newStr appendString:substring];
    }];
    
    return newStr;
}

- (BOOL)equals:(NSString *)str1 str2:(NSString *)str2 {
    return [str1 isEqualToString:str2];
}

- (void)printScro {
    
    NSLog(@"Score = %d",_nScore);
}


//是否包含特殊符号
- (BOOL)containSpecialCharacter:(NSString *)str {
    
    if ([str length] == 0) {
        return NO;
    }
    
    NSString *regex = @"[~!@#$%^&*()]";//规定的特殊字符，可以自己随意添加
    
    NSInteger str_length = [str length];
    for (int i = 0; i<str_length; i++) {
        //取出i
        NSString *subStr = [str substringWithRange:NSMakeRange(i, 1)];
        if([regex rangeOfString:subStr].location != NSNotFound)
        {  //存在
            return YES;
        }
    }
    
    return NO;
}

//包含其他字符
- (BOOL)containOther:(NSString *)str {
    
    if ([str length] == 0) {
        return NO;
    }
    
    NSString *pattern = @"[^a-zA-Z0-9_]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    BOOL isMatch = match != nil;
    return isMatch;
}

//是否包含小写字母
- (BOOL)containa_z:(NSString *)str {
    
    if ([str length] == 0) {
        return NO;
    }
    
    NSString *pattern = @"[a-z]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    BOOL isMatch = match != nil;
    return isMatch;
}

//是否包含大写字母
- (BOOL)containA_Z:(NSString *)str {
    
    if ([str length] == 0) {
        return NO;
    }
    
    NSString *pattern = @"[A-Z]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    BOOL isMatch = match != nil;
    return isMatch;
}

//是否包含数字
- (BOOL)contain0_9:(NSString *)str {
    
    if ([str length] == 0) {
        return NO;
    }
    
    NSString *pattern = @"[0-9]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    BOOL isMatch = match != nil;
    return isMatch;
}

@end
