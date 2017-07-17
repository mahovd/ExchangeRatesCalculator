//
//  ERCRateItem.m
//  ExchangeRatesCalculator
//
//  Created by Dmitriy Makhov on 11/07/2017.
//  Copyright © 2017 Dmitriy Makhov. All rights reserved.
//  model
//Конструктор и набор геттеров и сеттеров

#import "ERCRateItem.h"

@implementation ERCRateItem


- (instancetype)initWithItemId:(NSString *)rId rateName:(NSString *)rName rateValue:(double)rValue
{
    self = [super init];
    
    if (self) {
        _rateId = rId;
        _rateName = rName;
        _rateValue =rValue;
    }
    
    return self;
    
}

- (void)setRateId:(NSString *)rateId
{
    _rateId = rateId;
}

- (NSString*)rateId
{
    return _rateId;
}

- (void)setRateName:(NSString *)rateName
{
    _rateName = rateName;
}

- (NSString*)rateName
{
    return _rateName;
}

- (void)setRateValue:(double)rateValue
{
    _rateValue = rateValue;
}

- (double)rateValue
{
    return _rateValue;
}

@end
