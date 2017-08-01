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

UIColor *initialBackgroundColorOfInput = nil;
UIColor *disabledBackgroundColorOfInput = nil;



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
    
    
    initialBackgroundColorOfInput = self.rubAmountInput.backgroundColor;
    disabledBackgroundColorOfInput = [UIColor lightGrayColor];
    
    
    self.rubAmountInput.placeholder = @"enter amount";
    self.usdAmountInput.placeholder = @"enter amount";
    self.eurAmountInput.placeholder = @"enter amount";
    
}

- (IBAction)rubAmountInputEditStarted:(id)sender
{
    
    self.usdAmountInput.enabled = false;
    self.eurAmountInput.enabled = false;
    
    self.usdAmountInput.backgroundColor = disabledBackgroundColorOfInput;
    self.eurAmountInput.backgroundColor = disabledBackgroundColorOfInput;
    
}

- (IBAction)usdAmountInputEditStarted:(id)sender
{
    self.rubAmountInput.enabled = false;
    self.eurAmountInput.enabled = false;
    
    self.rubAmountInput.backgroundColor = disabledBackgroundColorOfInput;
    self.eurAmountInput.backgroundColor = disabledBackgroundColorOfInput;
}

- (IBAction)eurAmountInputEditStarted:(id)sender
{
    self.rubAmountInput.enabled = false;
    self.usdAmountInput.enabled = false;
    
    self.rubAmountInput.backgroundColor = disabledBackgroundColorOfInput;
    self.usdAmountInput.backgroundColor = disabledBackgroundColorOfInput;
}

- (IBAction)clearAllInputs:(id)sender
{
    self.rubAmountInput.text = @"";
    self.rubAmountInput.enabled = true;
    self.rubAmountInput.backgroundColor = initialBackgroundColorOfInput;
    
    self.usdAmountInput.text = @"";
    self.usdAmountInput.enabled = true;
    self.usdAmountInput.backgroundColor = initialBackgroundColorOfInput;
    
    self.eurAmountInput.text = @"";
    self.eurAmountInput.enabled = true;
    self.eurAmountInput.backgroundColor = initialBackgroundColorOfInput;
    
    
    //Remove focus from any input
    [self.rubAmountInput resignFirstResponder];
    [self.usdAmountInput resignFirstResponder];
    [self.eurAmountInput resignFirstResponder];
    
    
}

- (IBAction)calculateButtonPressed:(id)sender
{
    NSLog(@"Calculate button was pressed");
    if (self.rubAmountInput.isEnabled) {
        [self recalculateValues:@"RUB"];
    }
    else if (self.usdAmountInput.isEnabled) {
        [self recalculateValues:@"USD"];
    }
    else if (self.eurAmountInput.isEnabled){
        [self recalculateValues:@"EUR"];
    }
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
        self.usdAmountInput.text = [NSString stringWithFormat:@"%1.2f",usdVal];
        
        double eurVal = rubVal*currentRUBtoEURRate;
        
        self.eurAmountInput.text = [NSString stringWithFormat:@"%1.2f",eurVal];
        
        
    } else if ([currency isEqualToString:@"USD"]) {
        
        double usdVal = [self.usdAmountInput.text doubleValue];
        
        double rubVal = usdVal*currentUSDtoRUBRate;
        self.rubAmountInput.text = [NSString stringWithFormat:@"%1.2f",rubVal];
        
        double eurVal = usdVal*currentUSDtoEURRate;
        self.eurAmountInput.text = [NSString stringWithFormat:@"%1.2f",eurVal];
        
    } else if ([currency isEqualToString:@"EUR"])
    {
        
        double eurVal = [self.eurAmountInput.text doubleValue];
        
        double rubVal = eurVal*currentEURtoRUBRate;
        self.rubAmountInput.text = [NSString stringWithFormat:@"%1.2f",rubVal];
        
        double usdVal = eurVal*currentEURtoUSDRate;
        self.usdAmountInput.text = [NSString stringWithFormat:@"%1.2f",usdVal];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
