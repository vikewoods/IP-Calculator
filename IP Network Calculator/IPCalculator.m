//
//  IPCalculator.m
//  IP Network Calculator
//
//  Created by Vik Ewoods on 10/2/13.
//  Copyright (c) 2013 Vik Ewoods. All rights reserved.
//

#import "IPCalculator.h"

@implementation IPCalculator

// Classes Table
// Class    First Bit   Min IP      Max IP            Hosts
// A        0           1.0.0.0     126.0.0.1         2^24
// B        10          128.0.0.0   191.255.0.0       2^16
// C        110         192.0.1.0   223.255.255.0     2^8
// D        1110        224.0.0.0   239.255.255.255   Multicast
// E        11110       240.0.0.0   247.255.255.255   Reserved

// NOTES: CIDR -> Conver bits from 00000001 to 10000000
// NOTES: HOST -> (2^32-CIDR) - 2;

-(int)getCIDRprefixByMask:(NSString *)mask{
  if ([mask isEqualToString: @"255.255.255.255"]){
    cidrPrefix = 32;
  }else if ([mask isEqualToString:@"255.255.255.254"]) {
    cidrPrefix = 31;
  }else if ([mask isEqualToString:@"255.255.255.252"]){
    cidrPrefix = 30;
  }else if ([mask isEqualToString:@"255.255.255.248"]){
    cidrPrefix = 29;
  }else if ([mask isEqualToString:@"255.255.255.240"]){
    cidrPrefix = 28;
  }else if ([mask isEqualToString:@"255.255.255.224"]){
    cidrPrefix = 27;
  }else if ([mask isEqualToString:@"255.255.255.192"]){
    cidrPrefix = 26;
  }else if ([mask isEqualToString:@"255.255.255.128"]){
    cidrPrefix = 25;
  }else if ([mask isEqualToString:@"255.255.255.0"]){
    cidrPrefix = 24;
  }else if ([mask isEqualToString:@"255.255.254.0"]){
    cidrPrefix = 23;
  }else if ([mask isEqualToString:@"255.255.252.0"]){
    cidrPrefix = 22;
  }else if ([mask isEqualToString:@"255.255.248.0"]){
    cidrPrefix = 21;
  }else if ([mask isEqualToString:@"255.255.240.0"]){
    cidrPrefix = 20;
  }else if ([mask isEqualToString:@"255.255.224.0"]){
    cidrPrefix = 19;
  }else if ([mask isEqualToString:@"255.255.192.0"]){
    cidrPrefix = 18;
  }else if ([mask isEqualToString:@"255.255.128.0"]){
    cidrPrefix = 17;
  }else if ([mask isEqualToString:@"255.255.0.0"]){
    cidrPrefix = 16;
  }else if ([mask isEqualToString:@"255.254.0.0"]){
    cidrPrefix = 15;
  }else if ([mask isEqualToString:@"255.252.0.0"]){
    cidrPrefix = 14;
  }else if ([mask isEqualToString:@"255.248.0.0"]){
    cidrPrefix = 13;
  }else if ([mask isEqualToString:@"255.240.0.0"]){
    cidrPrefix = 12;
  }else if ([mask isEqualToString:@"255.224.0.0"]){
    cidrPrefix = 11;
  }else if ([mask isEqualToString:@"255.192.0.0"]){
    cidrPrefix = 10;
  }else if ([mask isEqualToString:@"255.128.0.0"]){
    cidrPrefix = 9;
  }else if ([mask isEqualToString:@"255.0.0.0"]){
    cidrPrefix = 8;
  }else if ([mask isEqualToString:@"254.0.0.0"]){
    cidrPrefix = 7;
  }else if ([mask isEqualToString:@"252.0.0.0"]){
    cidrPrefix = 6;
  }else if ([mask isEqualToString:@"248.0.0.0"]){
    cidrPrefix = 5;
  }else if ([mask isEqualToString:@"240.0.0.0"]){
    cidrPrefix = 4;
  }else if ([mask isEqualToString:@"224.0.0.0"]){
    cidrPrefix = 3;
  }else if ([mask isEqualToString:@"192.0.0.0"]){
    cidrPrefix = 2;
  }else if ([mask isEqualToString:@"128.0.0.0"]){
    cidrPrefix = 1;
  }else if ([mask isEqualToString:@"0.0.0.0"]){
    cidrPrefix = 0;
  }else{
    NSLog(@"Some errors with converting CIDR prefix");
  }
  NSLog(@"CIDR: %i", cidrPrefix);
  
    //NSLog(@"")
  return cidrPrefix;
}

-(int)calculateNetworkWithFullStartIP:(NSString *)full_start_ip WithFullEndIP:(NSString *)full_end_ip{
  // NOTES: Split start IP
  NSArray *splitLinesStartIP = [full_start_ip componentsSeparatedByString: @"."];
  int splitLinesStartIPA = [splitLinesStartIP[0] intValue];
  int splitLinesStartIPB = [splitLinesStartIP[1] intValue];
  int splitLinesStartIPC = [splitLinesStartIP[2] intValue];
  int splitLinesStartIPD = [splitLinesStartIP[3] intValue];
  
  // NOTES: Split end IP
  NSArray *splitLinesEndIP = [full_end_ip componentsSeparatedByString: @"."];
  int splitLinesEndIPA = [splitLinesEndIP[0] intValue];
  int splitLinesEndIPB = [splitLinesEndIP[1] intValue];
  int splitLinesEndIPC = [splitLinesEndIP[2] intValue];
  int splitLinesEndIPD = [splitLinesEndIP[3] intValue];
  
  // NOTES: Convert to decimal
  int startDecimalIp = splitLinesStartIPD + (splitLinesStartIPC * 256) + (splitLinesStartIPB * 256 * 256) + (splitLinesStartIPA * 256 * 256 * 256);
  int endDecimalIp = splitLinesEndIPD + (splitLinesEndIPC * 256) + (splitLinesEndIPB * 256 * 256) + (splitLinesEndIPA * 256 * 256 * 256);
  
  // NOTES: Log for now decimal
  //NSLog(@"Start network decimal: %i \n", startDecimalIp);
  //NSLog(@"End network decimal: %i \n", endDecimalIp);
  
  // NOTES: Log bins
  NSString *startDecimalIpBin = [self convertToBinWithDecimal:startDecimalIp];
  NSString *endDecimalIpBin = [self convertToBinWithDecimal:endDecimalIp];
  
  // NOTES: Split on octets
  NSArray *splitStartDecimalOnOctet = [startDecimalIpBin componentsSeparatedByString: @" "];
  NSString *splitStartDecimalOnOctet1 = splitStartDecimalOnOctet[0];
  NSString *splitStartDecimalOnOctet2 = splitStartDecimalOnOctet[1];
  NSString *splitStartDecimalOnOctet3 = splitStartDecimalOnOctet[2];
  NSString *splitStartDecimalOnOctet4 = splitStartDecimalOnOctet[3];
  
  NSArray *splitEndDecimalOnOctet = [endDecimalIpBin componentsSeparatedByString: @" "];
  NSString *splitEndDecimalOnOctet1 = splitEndDecimalOnOctet[0];
  NSString *splitEndDecimalOnOctet2 = splitEndDecimalOnOctet[1];
  NSString *splitEndDecimalOnOctet3 = splitEndDecimalOnOctet[2];
  NSString *splitEndDecimalOnOctet4 = splitEndDecimalOnOctet[3];
  
  if ([splitStartDecimalOnOctet3 isEqualToString:splitEndDecimalOnOctet3]) {
    NSLog(@"Last bits start: %@ \n", splitStartDecimalOnOctet3);
    NSLog(@"Last bits end: %@ \n", splitEndDecimalOnOctet3);
    NSLog(@"First 3 octet is equal");
  }else if ([splitStartDecimalOnOctet1 isEqualToString:splitEndDecimalOnOctet1] && [splitStartDecimalOnOctet2 isEqualToString:splitEndDecimalOnOctet2]){
    NSLog(@"Last bits start: %@ \n", splitStartDecimalOnOctet3);
    NSLog(@"Last bits end: %@ \n", splitEndDecimalOnOctet3);
    NSLog(@"First 2 octet is equal");
    // Reverse END of octet 2
    NSMutableString *reversedSplitEndDecimalOnOctet3 = [NSMutableString stringWithCapacity:[splitEndDecimalOnOctet3 length]];
    
    [splitEndDecimalOnOctet3 enumerateSubstringsInRange:NSMakeRange(0,[splitEndDecimalOnOctet3 length]) options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {                       [reversedSplitEndDecimalOnOctet3 appendString:substring];
    }];
    
    NSMutableString *reversedSplitEndDecimalOnOctet2 = [NSMutableString stringWithCapacity:[splitEndDecimalOnOctet2 length]];
    
    [splitEndDecimalOnOctet2 enumerateSubstringsInRange:NSMakeRange(0,[splitEndDecimalOnOctet2 length]) options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {                       [reversedSplitEndDecimalOnOctet2 appendString:substring];
    }];
    
    long int test = [startDecimalIpBin intValue] & [endDecimalIpBin intValue];
    long int first = [startDecimalIpBin intValue];
    long int last = [splitEndDecimalOnOctet3 intValue];
    first &= last;
    NSLog(@"Reverse last: %@", splitStartDecimalOnOctet);
    NSString* convertedTest = [NSString stringWithFormat:@"%ld", test];
    maskDecimal = [self convertToDecimalWithBin:convertedTest];
    maskToConvert = [NSString stringWithFormat:@"255.255.%li.0", maskDecimal];
    NSLog(@"Network mask: %@", maskToConvert);
    
    int CIDR = [self getCIDRprefixByMask:maskToConvert];
    [self totalHostClean:CIDR];
  }
  
  NSLog(@"Start binary: %@.%@.%@.%@", splitStartDecimalOnOctet1, splitStartDecimalOnOctet2, splitStartDecimalOnOctet3, splitStartDecimalOnOctet4);
  NSLog(@"End binary: %@.%@.%@.%@", splitEndDecimalOnOctet1, splitEndDecimalOnOctet2, splitEndDecimalOnOctet3, splitEndDecimalOnOctet4);
  
  return 0;
}

-(long int)totalHostClean:(int)mask{
    //long int totalHost = (2^(32-mask)) -2;
  mask = 19;
  long int totalHost = pow(2, (32-mask)) - 2;
  NSLog(@"Total %li hosts in network", totalHost);
  return totalHost;
}

-(id)convertToBinWithDecimal:(int)decimal{
  NSMutableString * binString = [[NSMutableString alloc] init];
  int spacing = pow(2, 3);
  int width = (sizeof(decimal)) * spacing;
  int binaryDigit = 0;
  int integer = decimal;
  while( binaryDigit < width ){
    binaryDigit++;
    [binString insertString:((integer & 1) ? @"1" : @"0" )atIndex:0];
    if( binaryDigit % spacing == 0 && binaryDigit != width ){
      [binString insertString:@" " atIndex:0];
    }
    integer = integer >> 1;
  }
  return binString;
}

-(long)convertToDecimalWithBin:(NSString *)bin{
  long decimal_converted = strtol([bin UTF8String], NULL, 2);
  return decimal_converted;
}


@end
