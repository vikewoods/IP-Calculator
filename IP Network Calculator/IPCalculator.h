//
//  IPCalculator.h
//  IP Network Calculator
//
//  Created by Vik Ewoods on 10/2/13.
//  Copyright (c) 2013 Vik Ewoods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPCalculator : NSObject{
  int ipA; // 192
  int ipB; // 168
  int ipC; // 0
  int ipD; // 1
  int CleanSum; // 255
  int DirtSum; // 254
  int cidrPrefix;
  int dirtyPrefix;
  NSString *maskToConvert;
  long int maskDecimal;
}

// Return summary
-(int)calculateNetworkWithFullStartIP:(NSString *)full_start_ip WithFullEndIP:(NSString *)full_end_ip;
-(id)convertToBinWithDecimal:(int)decimal;
-(long)convertToDecimalWithBin:(NSString *)bin;
-(int)getCIDRprefixByMask:(NSString *)mask;

@end
