//
//  NSDate+Formatter.h
//  test
//
//  Created by Mikhail Prysiazhniy on 10.04.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)



/**
 *  @return dd/MM/YYYY HH:mm:ss'(GMT)'
 */
- (NSString *)getFormattedGMTTime;

/**
 *  @return dd/MM/YYYY HH:mm:ss
 */
- (NSString *)getFormattedGMTTimeWithoutText;

/**
 *  @return dd/MM HH:mm:ss
 */
- (NSString *)getFormattedGMTTimeWithoutYear;

/**
 *  @return YYYY-MM-dd HH:mm:ss
 */
- (NSString *)dateStringServerFormat;


    


@end
