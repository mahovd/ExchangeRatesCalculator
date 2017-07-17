//
//  ViewController.m
//  ExchangeRatesCalculator
//
//  Created by Dmitriy Makhov on 06/07/2017.
//  Copyright © 2017 Dmitriy Makhov. All rights reserved.
//  controller

#import "ViewController.h"
#import "ERCDataManager.h"
#import "ERCRateItem.h"

@interface ViewController ()

@property (nonatomic,weak) IBOutlet UITextField *rubAmountInput;
@property (nonatomic,weak) IBOutlet UITextField *usdAmountInput;
@property (nonatomic,weak) IBOutlet UITextField *eurAmountInput;


@end

@implementation ViewController

NSMutableArray *currentRates = nil;


- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    
    //Call the init method implemented by the superclass
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        //запускаем процесс по получению данных
        ERCDataManager *manager = [[ERCDataManager alloc]init];
        currentRates = [manager getData];
        NSLog(@"initWithCoder");
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad");
    
    
    self.rubAmountInput.placeholder = @"enter amount";
    self.usdAmountInput.placeholder = @"enter amount";
    self.eurAmountInput.placeholder = @"enter amount";
    
}


- (IBAction) rubValueChanged:(id)sender
{
    
    [self recalculateValues:@"RUB"];
}

- (IBAction) usdValueChanged:(id)sender
{

    [self recalculateValues:@"USD"];
    
}

- (IBAction) eurValueChanged:(id)sender
{
    [self recalculateValues:@"EUR"];
}

//Основной метод по расчету новых значений, надо бы вынести из этого класса, но время поджимает
- (void)recalculateValues:(NSString*)currency{
    
    //NSDecimalNumber *currentUSDtoRUBRate = currentRates[0];
    ERCRateItem *itmRUBUSD = currentRates[0];
    ERCRateItem *itmRUBEUR = currentRates[1];
    ERCRateItem *itmUSDRUB = currentRates[2];
    ERCRateItem *itmUSDEUR = currentRates[3];
    ERCRateItem *itmEURRUB = currentRates[4];
    ERCRateItem *itmEURUSD = currentRates[5];
    
    double currentRUBtoUSDRate = itmRUBUSD.rateValue;
    double currentRUBtoEURRate = itmRUBEUR.rateValue;
    double currentUSDtoRUBRate = itmUSDRUB.rateValue;
    double currentUSDtoEURRate = itmUSDEUR.rateValue;
    double currentEURtoRUBRate = itmEURRUB.rateValue;
    double currentEURtoUSDRate = itmEURUSD.rateValue;
    
    
    
    if ([currency isEqualToString:@"RUB"]) {
        
        double rubVal = [self.rubAmountInput.text doubleValue];
        
        double usdVal = rubVal*currentRUBtoUSDRate;
        self.usdAmountInput.text = [NSString stringWithFormat:@"%f",usdVal];
        
        double eurVal = rubVal*currentRUBtoEURRate;
        
        self.eurAmountInput.text = [NSString stringWithFormat:@"%f",eurVal];
        
        
    } else if ([currency isEqualToString:@"USD"]) {
        
        double usdVal = [self.usdAmountInput.text doubleValue];
        
        double rubVal = usdVal*currentUSDtoRUBRate;
        self.rubAmountInput.text = [NSString stringWithFormat:@"%f",rubVal];
        
        double eurVal = usdVal*currentUSDtoEURRate;
        self.eurAmountInput.text = [NSString stringWithFormat:@"%f",eurVal];
        
    } else if ([currency isEqualToString:@"EUR"])
    {
        
        double eurVal = [self.eurAmountInput.text doubleValue];
        
        double rubVal = eurVal*currentEURtoRUBRate;
        self.rubAmountInput.text = [NSString stringWithFormat:@"%f",rubVal];
        
        double usdVal = eurVal*currentEURtoUSDRate;
        self.usdAmountInput.text = [NSString stringWithFormat:@"%f",usdVal];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
