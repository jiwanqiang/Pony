//
//  UIImage+Resize.m
//
//  Copyright (c) 2014 Wanqiang Ji
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)resizeWithScale:(float)scale
{
    return [UIImage imageWithCGImage:self.CGImage scale:scale orientation:self.imageOrientation];
}

- (UIImage *)cropWithBounds:(CGRect)bounds
{
    CGImageRef newImgRef = CGImageCreateWithImageInRect(self.CGImage, bounds);
    UIImage *newImg = [UIImage imageWithCGImage:newImgRef];
    CGImageRelease(newImgRef);
    return newImg;
}

- (UIImage *)resizeWithSize:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality
{
    return nil;
}

- (UIImage *)resizeWithSize:(CGSize)newSize transform:(CGAffineTransform)transform drawTransposed:(BOOL)transpose interpolationQuality:(CGInterpolationQuality)quality
{
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imgRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imgRef),
                                                0,
                                                CGImageGetColorSpace(imgRef),
                                                CGImageGetBitmapInfo(imgRef));
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imgRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImgRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImgRef scale:1.0 orientation:self.imageOrientation];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImgRef);
    
    return newImage;
}

@end
