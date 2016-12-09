//
//  CreateSupplyPDF.h
//  Yi_Fei
//
//  Created by yons on 16/12/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface CreateSupplyPDF : NSObject

+ (void)drawText:(NSString*)text inFrame:(CGRect)frame fontName:(NSString *)fontName fontSize:(int) fontSize;

+(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to;

+(void)drawImage:(UIImage*)image inRect:(CGRect)rect;

- (void)createPDF:(NSString*)filePath;

@property (nonatomic,strong)shopData *shopObjc;



@end








