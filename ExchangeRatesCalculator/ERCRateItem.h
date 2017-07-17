//
//  ERCRateItem.h
//  ExchangeRatesCalculator
//
//  Created by Dmitriy Makhov on 11/07/2017.
//  Copyright © 2017 Dmitriy Makhov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERCRateItem : NSObject

{
    NSString         * _rateId;
    NSString         * _rateName;
    double             _rateValue;
}

//Designated initializer for ERCRateItem
- (instancetype)initWithItemId:(NSString *)rId rateName:(NSString *)rName rateValue:(double)rValue;

- (void)setRateId:(NSString*)rateId;
- (NSString*)rateId;


- (void)setRateName:(NSString*)rateName;
- (NSString*)rateName;

- (void)setRateValue:(NSDecimalNumber*)rateValue;
- (double)rateValue;

@end
