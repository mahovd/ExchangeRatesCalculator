//
//  ERCDataManager.m
//  ExchangeRatesCalculator
//
//  Created by Dmitriy Makhov on 15/07/2017.
//  Copyright © 2017 Dmitriy Makhov. All rights reserved.
// controller

#import "ERCDataManager.h"
#import "ERCRateItem.h"

@interface ERCDataManager ()

@property (nonatomic, copy) NSArray *courses;

@end

@implementation ERCDataManager


//Получает данные по курсам c ресурса yahoo,
//парсит и передает результат в виде массива
//в случае отсутствия подключения к интернет,
//отдает данные из сохраненного результата

- (NSMutableArray*)getData
{
    
    NSMutableArray *rates = [[NSMutableArray alloc]init];
    NSError *error;
    
    NSURL *url = [NSURL URLWithString:@"https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.xchange+where+pair+=+%22RUBUSD,RUBEUR,USDRUB,USDEUR,EURRUB,EURUSD%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //Если объект не проинициилизирован (скорее всего нет соединения), берем данные из строки
    if (data == nil) {
        //In case of no connection read rates from the saved result
                        data = [@"{\n"
                                "\"query\": {\n"
                                "\"count\": 6,\n"
                                "\"created\": \"2017-07-17T08:21:31Z\",\n"
                                "\"lang\": \"en-US\",\n"
                                "\"results\": {\n"
                                "\"rate\": [\n"
                                "{\n"
                                "\"id\": \"RUBUSD\",\n"
                                "\"Name\": \"RUB/USD\",\n"
                                "\"Rate\": \"0.0169\",\n"
                                "\"Date\": \"7/17/2017\",\n"
                                "\"Time\": \"6:11pm\",\n"
                                "\"Ask\": \"60.1230\",\n"
                                "\"Bid\": \"60.0730\"\n"
                                "},\n"
                                "{\n"
                                "\"id\": \"RUBEUR\",\n"
                                "\"Name\": \"RUB/EUR\",\n"
                                "\"Rate\": \"0.0148\",\n"
                                "\"Date\": \"7/5/2017\",\n"
                                "\"Time\": \"6:11pm\",\n"
                                "\"Ask\": \"68.1460\",\n"
                                "\"Bid\": \"68.1170\"\n"
                                "},\n"
                                "{\n"
                                "\"id\": \"USDRUB\",\n"
                                "\"Name\": \"USD/RUB\",\n"
                                "\"Rate\": \"59.0360\",\n"
                                "\"Date\": \"7/5/2017\",\n"
                                "\"Time\": \"6:10pm\",\n"
                                "\"Ask\": \"0.0147\",\n"
                                "\"Bid\": \"0.0146\"\n"
                                "},\n"
                                "{\n"
                                "\"id\": \"USDEUR\",\n"
                                "\"Name\": \"USD/EUR\",\n"
                                "\"Rate\": \"0.8720\",\n"
                                "\"Date\": \"7/5/2017\",\n"
                                "\"Time\": \"6:10pm\",\n"
                                "\"Ask\": \"0.0147\",\n"
                                "\"Bid\": \"0.0146\"\n"
                                "},\n"
                                "{\n"
                                "\"id\": \"EURRUB\",\n"
                                "\"Name\": \"EUR/RUB\",\n"
                                "\"Rate\": \"67.7000\",\n"
                                "\"Date\": \"7/5/2017\",\n"
                                "\"Time\": \"6:10pm\",\n"
                                "\"Ask\": \"0.0147\",\n"
                                "\"Bid\": \"0.0146\"\n"
                                "},\n"
                                "{\n"
                                "\"id\": \"EURUSD\",\n"
                                "\"Name\": \"EUR/USD\",\n"
                                "\"Rate\": \"1.1461\",\n"
                                "\"Date\": \"7/5/2017\",\n"
                                "\"Time\": \"6:10pm\",\n"
                                "\"Ask\": \"0.0147\",\n"
                                "\"Bid\": \"0.0146\"\n"
                                "}\n"
                                "]\n"
                                "}\n"
                                "}\n"
                                "}" dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSLog(@"%@",jsonObject);
    
    //вытаскиваем нужный кусок ответа
    self.courses = [[ [jsonObject objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"rate"];
    
    //пакуем ответы в общий массив
    for (NSDictionary *nsd in self.courses) {
        
        ERCRateItem *rateItem = [[ERCRateItem alloc]initWithItemId:[nsd objectForKey:@"id"] rateName:[nsd objectForKey:@"Name"] rateValue:[[nsd objectForKey:@"Rate"]doubleValue]];
        
        [rates addObject:rateItem];
        
    }
    
    
    return rates;
    
}

@end
