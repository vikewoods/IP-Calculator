//
//  main.m
//  IP Network Calculator
//
//  Created by Vik Ewoods on 10/2/13.
//  Copyright (c) 2013 Vik Ewoods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPCalculator.h"
#import "CSVParse.h"

int main(int argc, const char * argv[])
{

  @autoreleasepool {
    
    long testing;
    int cidr;
      IPCalculator *CalculatorIP;
      CalculatorIP = [[IPCalculator alloc] init];
      [CalculatorIP calculateNetworkWithFullStartIP:@"1.0.8.0" WithFullEndIP:@"1.0.15.255"];
    cidr = [CalculatorIP getCIDRprefixByMask:@"255.255.255.254"];
    testing = [CalculatorIP convertToDecimalWithBin:@"11111000"];
    NSLog(@"Testing: %li", testing);
    // Table country
    printf("+-------------------------------------------------------------+\n");
    printf("| Country:        | Total host 1:       | Total hosts 2:      |\n");
    printf("|-------------------------------------------------------------|\n");
    printf("|                 |");printf(" %i | ", cidr);printf(" %i |\n", cidr);
    printf("===============================================================\n");
    printf("*1 - total host; *2 total hosts with network and broadcast ips \n");
    printf("===============================================================\n");
    
    
      
  }
  return 0;
}

