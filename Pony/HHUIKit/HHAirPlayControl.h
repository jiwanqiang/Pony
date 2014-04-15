//
//  HHAirPlayControl.h
//
//  Copyright (c) 2012 Wanqiang Ji
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
//
//  You must add the framework that is AudioToolBox in your project target.

#import <MediaPlayer/MediaPlayer.h>

@interface HHAirPlayControl : UIView
{
    UIButton        *_airPlayButton;
    UIButton        *_mpButton;
    MPVolumeView    *_volumeView;
    
    NSNetServiceBrowser *_serviceBrowser;
    NSMutableArray      *_foundServices;
    
    BOOL    _isDetected;
    CGRect  _frame;
}

@property (nonatomic, retain) NSString *notDetected;
@property (nonatomic, retain) NSString *detected;
@property (nonatomic, retain) NSString *playing;

- (HHAirPlayControl *)initWithFrame:(CGRect)frame withDetected:(NSString*)detected notDetected:(NSString*)notDetected playing:(NSString*)playing;

@end
