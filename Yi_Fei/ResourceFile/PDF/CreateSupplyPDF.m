//
//  CreateSupplyPDF.m
//  Yi_Fei
//
//  Created by yons on 16/12/9.
//  Copyright © 2016年 ZMJPersonal. All rights reserved.
//

#import "CreateSupplyPDF.h"

@implementation CreateSupplyPDF


+(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frame fontName:(NSString *)fontName fontSize:(int) fontSize
{
    if (textToDraw.length > 0) {
        CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)fontName, fontSize, NULL);
        CFStringRef keys[] = { kCTFontAttributeName };
        CFTypeRef values[] = { font };
        CFDictionaryRef attr = CFDictionaryCreate(NULL, (const void **)&keys, (const void **)&values,
                                                  sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        
        CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, attr);
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(currentText);
        CGRect frameRect = (CGRect){frame.origin.x, -1 * frame.origin.y, frame.size};
        CGMutablePathRef framePath = CGPathCreateMutable();
        CGPathAddRect(framePath, NULL, frameRect);
        CFRange currentRange = CFRangeMake(0, 0);
        CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, currentRange, framePath, NULL);
        CGPathRelease(framePath);
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
        CGContextScaleCTM(currentContext, 1.0, -1.0);
        CTFrameDraw(frameRef, currentContext);
        CGContextScaleCTM(currentContext, 1.0, -1.0);
        CFRelease(frameRef);
        CFRelease(stringRef);
        CFRelease(frameSetter);
    }
}

+(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.0, 0.0, 0.0, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
}


+(void)drawImage:(UIImage*)image inRect:(CGRect)rect{
    [image drawInRect:rect];
}


- (void)createPDF:(NSString*)filePath
{
    UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 1000, 1300), nil);
    
    CGPoint fromOne = CGPointMake(110, 30);
    CGPoint toOne = CGPointMake(890, 30);
    [CreateSupplyPDF drawLineFromPoint:fromOne toPoint:toOne];
    
    CGPoint fromTwo = CGPointMake(110, 30);
    CGPoint toTwo = CGPointMake(110, 890);
    [CreateSupplyPDF drawLineFromPoint:fromTwo toPoint:toTwo];
    
    CGPoint fromThree = CGPointMake(890, 30);
    CGPoint toThree = CGPointMake(890, 890);
    [CreateSupplyPDF drawLineFromPoint:fromThree toPoint:toThree];
    
    CGPoint fromFour = CGPointMake(110, 120);
    CGPoint toFour = CGPointMake(890, 120);
    [CreateSupplyPDF drawLineFromPoint:fromFour toPoint:toFour];
    
    [CreateSupplyPDF drawText:@"商品报价单" inFrame:CGRectMake(420, 115, 200, 60) fontName:@"Arial" fontSize:32];
    CGPoint fromFive = CGPointMake(110, 170);
    CGPoint toFive = CGPointMake(890, 170);
    [CreateSupplyPDF drawLineFromPoint:fromFive toPoint:toFive];
    
    //第二行
    CGPoint fromSix = CGPointMake(280, 120);
    CGPoint toSix = CGPointMake(280, 170);
    [CreateSupplyPDF drawLineFromPoint:fromSix toPoint:toSix];
    [CreateSupplyPDF drawText:@"客户姓名" inFrame:CGRectMake(150, 170, 180, 40) fontName:@"Arial" fontSize:24];
    
    
    CGPoint fromSeven = CGPointMake(480, 120);
    CGPoint toSeven = CGPointMake(480, 170);
    [CreateSupplyPDF drawLineFromPoint:fromSeven toPoint:toSeven];
    [CreateSupplyPDF drawText:@"张明军" inFrame:CGRectMake(350, 170, 200, 40) fontName:@"Arial" fontSize:22];
    
    CGPoint fromEight = CGPointMake(650, 120);
    CGPoint toEight = CGPointMake(650, 170);
    [CreateSupplyPDF drawLineFromPoint:fromEight toPoint:toEight];
    [CreateSupplyPDF drawText:@"报价时间" inFrame:CGRectMake(520, 170, 150, 40) fontName:@"Arial" fontSize:24];
    [CreateSupplyPDF drawText:@"2016-12-05" inFrame:CGRectMake(700, 175, 150, 40) fontName:@"Arial" fontSize:22];
    
    //第三行
    CGPoint ThreeLine = CGPointMake(110, 330);
    CGPoint toThreeLine = CGPointMake(890, 330);
    [CreateSupplyPDF drawLineFromPoint:ThreeLine toPoint:toThreeLine];
    
    
    CGPoint threeOne = CGPointMake(280, 170);
    CGPoint toThreeOne = CGPointMake(280, 330);
    [CreateSupplyPDF drawLineFromPoint:threeOne toPoint:toThreeOne];
    [CreateSupplyPDF drawText:@"产品图片" inFrame:CGRectMake(150, 270, 180, 40) fontName:@"Arial" fontSize:24];
    
    
    NSMutableArray *imageArray = [NSMutableArray array];
NSArray *arrayimg=[_shopObjc.shopPicture componentsSeparatedByString:@"|"];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    for (NSInteger i = 0 ; i < arrayimg.count; i++) {
        NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",arrayimg[i]]];
        [imageArray addObject:imagePath];
        
        if (i == 0) {
            UIImage* logoOne = [UIImage imageWithContentsOfFile:imageArray[i]];
            CGRect frameOne = CGRectMake(280, 170, 145, 160);
            [CreateSupplyPDF drawImage:logoOne inRect:frameOne];
        }else if (i == 1){
           UIImage* logoTwo = [UIImage imageWithContentsOfFile:imageArray[i]];
            CGRect frameTwo = CGRectMake(425, 170, 145, 160);
            [CreateSupplyPDF drawImage:logoTwo inRect:frameTwo];
            
        }else if (i == 2){
             UIImage* logoThree = [UIImage imageWithContentsOfFile:imageArray[i]];
            CGRect frameThree = CGRectMake(570, 170, 145, 160);
            [CreateSupplyPDF drawImage:logoThree inRect:frameThree];
        }else if (i == 3){
        UIImage* logoFour = [UIImage imageWithContentsOfFile:imageArray[i]];
            CGRect frameFour = CGRectMake(715, 170, 145, 160);
            [CreateSupplyPDF drawImage:logoFour inRect:frameFour];
        }
    }
    

    //第四行
    CGPoint fourLine = CGPointMake(110, 390);
    CGPoint toFourLine = CGPointMake(890, 390);
    [CreateSupplyPDF drawLineFromPoint:fourLine toPoint:toFourLine];
    [CreateSupplyPDF drawText:@"产品参数详情" inFrame:CGRectMake(400, 400, 200, 60) fontName:@"Arial" fontSize:28];
    
    //第五行
    
    CGPoint fiveLine = CGPointMake(110, 440);
    CGPoint toFiveLine = CGPointMake(890, 440);
    [CreateSupplyPDF drawLineFromPoint:fiveLine toPoint:toFiveLine];
    
    CGPoint fiveLineOne = CGPointMake(280, 390);
    CGPoint toFiveLineOne = CGPointMake(280, 440);
    [CreateSupplyPDF drawLineFromPoint:fiveLineOne toPoint:toFiveLineOne];
    [CreateSupplyPDF drawText:@"商品名称" inFrame:CGRectMake(150, 440, 180, 40) fontName:@"Arial" fontSize:24];
    
    CGPoint fiveLineTwo = CGPointMake(480, 390);
    CGPoint toFiveLineTwo = CGPointMake(480, 440);
    [CreateSupplyPDF drawLineFromPoint:fiveLineTwo toPoint:toFiveLineTwo];
    [CreateSupplyPDF drawText:_shopObjc.shopName inFrame:CGRectMake(350, 440, 200, 40) fontName:@"Arial" fontSize:22];
    
    CGPoint fiveLineThree = CGPointMake(650, 390);
    CGPoint toFiveLineThree = CGPointMake(650, 440);
    [CreateSupplyPDF drawLineFromPoint:fiveLineThree toPoint:toFiveLineThree];
    [CreateSupplyPDF drawText:@"商品价格" inFrame:CGRectMake(520, 440, 150, 40) fontName:@"Arial" fontSize:24];
    [CreateSupplyPDF drawText:_shopObjc.shopPrice inFrame:CGRectMake(700, 440, 150, 40) fontName:@"Arial" fontSize:22];
    
    
    //第六行
    CGPoint sixLine = CGPointMake(110, 490);
    CGPoint toSixLine = CGPointMake(890, 490);
    [CreateSupplyPDF drawLineFromPoint:sixLine toPoint:toSixLine];
    
    CGPoint sixLineOne = CGPointMake(280, 440);
    CGPoint toSixLineOne = CGPointMake(280, 490);
    [CreateSupplyPDF drawLineFromPoint:sixLineOne toPoint:toSixLineOne];
    [CreateSupplyPDF drawText:@"公司货号" inFrame:CGRectMake(150, 490, 180, 40) fontName:@"Arial" fontSize:24];
    
    CGPoint SixLineTwo = CGPointMake(480, 440);
    CGPoint toSixLineTwo = CGPointMake(480, 490);
    [CreateSupplyPDF drawLineFromPoint:SixLineTwo toPoint:toSixLineTwo];
    [CreateSupplyPDF drawText:_shopObjc.companyID inFrame:CGRectMake(350, 490, 200, 40) fontName:@"Arial" fontSize:22];
    
    CGPoint SixLineThree = CGPointMake(650, 440);
    CGPoint toSixLineThree = CGPointMake(650, 490);
    [CreateSupplyPDF drawLineFromPoint:SixLineThree toPoint:toSixLineThree];
    [CreateSupplyPDF drawText:@"商品材质" inFrame:CGRectMake(520, 490, 150, 40) fontName:@"Arial" fontSize:24];
    [CreateSupplyPDF drawText:_shopObjc.shopMed inFrame:CGRectMake(700, 490, 150, 40) fontName:@"Arial" fontSize:22];
    
    //第七行
    CGPoint sevenLine = CGPointMake(110, 540);
    CGPoint toSevenLine = CGPointMake(890, 540);
    [CreateSupplyPDF drawLineFromPoint:sevenLine toPoint:toSevenLine];
    
    CGPoint sevenLineOne = CGPointMake(280, 490);
    CGPoint toSevenLineOne = CGPointMake(280, 540);
    [CreateSupplyPDF drawLineFromPoint:sevenLineOne toPoint:toSevenLineOne];
    [CreateSupplyPDF drawText:@"商品尺寸" inFrame:CGRectMake(150, 540, 180, 40) fontName:@"Arial" fontSize:24];
    
    CGPoint sevenLineTwo = CGPointMake(480, 490);
    CGPoint toSevenLineTwo = CGPointMake(480, 540);
    [CreateSupplyPDF drawLineFromPoint:sevenLineTwo toPoint:toSevenLineTwo];
    [CreateSupplyPDF drawText:_shopObjc.shopSize inFrame:CGRectMake(350, 540, 200, 40) fontName:@"Arial" fontSize:22];
    
    CGPoint sevenLineThree = CGPointMake(650, 490);
    CGPoint toSevenLineThree = CGPointMake(650, 540);
    [CreateSupplyPDF drawLineFromPoint:sevenLineThree toPoint:toSevenLineThree];
    [CreateSupplyPDF drawText:@"商品颜色" inFrame:CGRectMake(520, 540, 150, 40) fontName:@"Arial" fontSize:24];
    [CreateSupplyPDF drawText:_shopObjc.shopColor inFrame:CGRectMake(700, 540, 150, 40) fontName:@"Arial" fontSize:22];
    
    
    //第八行
    CGPoint eightLine = CGPointMake(110, 590);
    CGPoint toEightLine = CGPointMake(890, 590);
    [CreateSupplyPDF drawLineFromPoint:eightLine toPoint:toEightLine];
    
    CGPoint eightLineOne = CGPointMake(280, 540);
    CGPoint toEightLineOne = CGPointMake(280, 590);
    [CreateSupplyPDF drawLineFromPoint:eightLineOne toPoint:toEightLineOne];
    [CreateSupplyPDF drawText:@"价格条款" inFrame:CGRectMake(150, 590, 180, 40) fontName:@"Arial" fontSize:24];
    
    CGPoint seightLineTwo = CGPointMake(480, 540);
    CGPoint toEightLineTwo = CGPointMake(480, 590);
    [CreateSupplyPDF drawLineFromPoint:seightLineTwo toPoint:toEightLineTwo];
    [CreateSupplyPDF drawText:_shopObjc.shopTiaoK inFrame:CGRectMake(350, 590, 200, 40) fontName:@"Arial" fontSize:22];
    
    CGPoint eightLineThree = CGPointMake(650, 540);
    CGPoint toEightLineThree = CGPointMake(650, 590);
    [CreateSupplyPDF drawLineFromPoint:eightLineThree toPoint:toEightLineThree];
    [CreateSupplyPDF drawText:@"货币类型" inFrame:CGRectMake(520, 590, 150, 40) fontName:@"Arial" fontSize:24];
    [CreateSupplyPDF drawText:_shopObjc.shopHuoBi inFrame:CGRectMake(700, 590, 150, 40) fontName:@"Arial" fontSize:22];
    
    
    //第九行
    CGPoint nineLine = CGPointMake(110, 640);
    CGPoint toNineLine = CGPointMake(890, 640);
    [CreateSupplyPDF drawLineFromPoint:nineLine toPoint:toNineLine];
    
    CGPoint nineLineOne = CGPointMake(280, 590);
    CGPoint toNineLineOne = CGPointMake(280, 640);
    [CreateSupplyPDF drawLineFromPoint:nineLineOne toPoint:toNineLineOne];
    [CreateSupplyPDF drawText:@"商品介绍" inFrame:CGRectMake(150, 640, 180, 40) fontName:@"Arial" fontSize:24];
    
    CGPoint nineLineTwo = CGPointMake(480, 590);
    CGPoint toNineLineTwo = CGPointMake(480, 640);
    [CreateSupplyPDF drawLineFromPoint:nineLineTwo toPoint:toNineLineTwo];
    [CreateSupplyPDF drawText:_shopObjc.shopInfo inFrame:CGRectMake(350, 640, 200, 40) fontName:@"Arial" fontSize:22];
    
    CGPoint nineLineThree = CGPointMake(650, 590);
    CGPoint toNineLineThree = CGPointMake(650, 640);
    [CreateSupplyPDF drawLineFromPoint:nineLineThree toPoint:toNineLineThree];
    [CreateSupplyPDF drawText:@"商品备注" inFrame:CGRectMake(520, 640, 150, 40) fontName:@"Arial" fontSize:24];
    [CreateSupplyPDF drawText:_shopObjc.shopDescribe inFrame:CGRectMake(700, 640, 150, 40) fontName:@"Arial" fontSize:22];
    
    
    
    
    NSArray * customArray =[_shopObjc.shopCustom componentsSeparatedByString:@"|"];
    NSArray * bodyArray = [_shopObjc.shopContent componentsSeparatedByString:@"|"];

    for (NSInteger i = 0 ; i < customArray.count ; i++) {
        NSInteger count = i / 2;
        CGPoint nineLine = CGPointMake(110, 690 + count * 50);
        CGPoint toNineLine = CGPointMake(890, 690 + count * 50);
        [CreateSupplyPDF drawLineFromPoint:nineLine toPoint:toNineLine];
        
        if (i  % 2 == 0 ) {
            
            CGPoint lineOne = CGPointMake(280, 640 + count * 50);
            CGPoint toLineOne = CGPointMake(280, 690 + count * 50);
            [CreateSupplyPDF drawLineFromPoint:lineOne toPoint:toLineOne];
            NSString *str = [NSString stringWithFormat:customArray[i],(long)i];
            [CreateSupplyPDF drawText:str inFrame:CGRectMake(150, 690 + count * 50, 180, 40) fontName:@"Arial" fontSize:24];
            
            CGPoint LineTwo = CGPointMake(480, 590 + count * 50);
            CGPoint toLineTwo = CGPointMake(480, 640 + count * 50);
            [CreateSupplyPDF drawLineFromPoint:LineTwo toPoint:toLineTwo];
            [CreateSupplyPDF drawText:bodyArray[i] inFrame:CGRectMake(350, 690 + count * 50, 200, 40) fontName:@"Arial" fontSize:22];
            
        }else{
            CGPoint lineThree = CGPointMake(650, 640 + count * 50);
            CGPoint toLineThree = CGPointMake(650, 690 + count * 50);
            [CreateSupplyPDF drawLineFromPoint:lineThree toPoint:toLineThree];
            NSString *strTwo = [NSString stringWithFormat:customArray[i],(long)i];
            
            [CreateSupplyPDF drawText:strTwo inFrame:CGRectMake(520, 690 + count * 50, 150, 40) fontName:@"Arial" fontSize:24];
            [CreateSupplyPDF drawText:bodyArray[i] inFrame:CGRectMake(700, 690 + count * 50, 150, 40) fontName:@"Arial" fontSize:22];
            
        }
    }
    
    UIGraphicsEndPDFContext();
}










@end




















