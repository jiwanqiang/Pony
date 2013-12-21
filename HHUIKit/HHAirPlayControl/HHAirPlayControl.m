//
//  HHAirPlayControl.m
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

#import "HHAirPlayControl.h"
#import <AudioToolbox/AudioToolbox.h>

/////////////////////////////////////////////////////////////////////////
@interface HHAirPlayControl()<NSNetServiceBrowserDelegate,NSNetServiceDelegate>

- (void)initAirButtonWithFrame:(CGRect)frame;
- (BOOL)isAirPlayActive;
- (void)setAirPlayButtonSelected:(BOOL)selected;

- (void)setAirPlayButtonAvailable:(BOOL)available;
- (void)detectOutDevice;

@end
/////////////////////////////////////////////////////////////////////////
@implementation WQAirPlayView
@synthesize notDetected = _notDetected;
@synthesize detected = _detected;
@synthesize playing = _playing;

- (void)dealloc
{
    [_notDetected release];
    [_detected release];
    [_playing release];
    
//    AudioSessionRemovePropertyListenerWithUserData(kAudioSessionProperty_AudioRouteChange, audioRouteChangeCallback, (void*)self);
    [super dealloc];
}

- (WQAirPlayView*)initWithFrame:(CGRect)frame
                   withDetected:(NSString*)detected
                    notDetected:(NSString*)notDetected
                        playing:(NSString*)playing
{
    _frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.detected = detected;
        self.notDetected = notDetected;
        self.playing = playing;
        [self detectOutDevice];
        [self initAirButtonWithFrame:_frame];
    }
    return self;
}
#pragma mark - Create custom views

- (void)initAirButtonWithFrame:(CGRect)frame
{
    _airPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_airPlayButton setFrame:frame];
    [self setAirPlayButtonSelected:_isDetected];
    [self addSubview:_airPlayButton];
}

#pragma mark -
- (void)setAirPlayButtonSelected:(BOOL)selected
{
    NSLog(@"%s\t%d",__FUNCTION__,__LINE__);
    UIImage* image;
    if (selected) {
        image = [UIImage imageNamed:_playing];
    }else {
        image = [UIImage imageNamed:_notDetected];
    }
    [_airPlayButton setImage:image forState:UIControlStateNormal];
    [_airPlayButton setImage:image forState:UIControlStateHighlighted];
    [_airPlayButton setImage:image forState:UIControlStateSelected];
}
- (BOOL)isAirPlayActive
{
    NSLog(@"%s\t%d",__FUNCTION__,__LINE__);
    CFDictionaryRef currentRouteDescriptionDictionary = nil;
    
    UInt32 dataSize = sizeof(currentRouteDescriptionDictionary);
    
    AudioSessionGetProperty(kAudioSessionProperty_AudioRouteDescription, &dataSize, &currentRouteDescriptionDictionary);
    
    if (currentRouteDescriptionDictionary) {
        CFArrayRef outputs = CFDictionaryGetValue(currentRouteDescriptionDictionary, kAudioSession_AudioRouteKey_Outputs);
        if(CFArrayGetCount(outputs) > 0) {
            CFDictionaryRef currentOutput = CFArrayGetValueAtIndex(outputs, 0);
            CFStringRef outputType = CFDictionaryGetValue(currentOutput, kAudioSession_AudioRouteKey_Type);
            return (CFStringCompare(outputType, kAudioSessionOutputRoute_AirPlay, 0) == kCFCompareEqualTo);
        }
    }
    return NO;
}

/////////////////////////////////////////////////////////////////////////
- (void)detectOutDevice
{
    NSLog(@"%s\t%d",__FUNCTION__,__LINE__);
    _isDetected = FALSE;
    _serviceBrowser = [[NSNetServiceBrowser alloc] init];
    [_serviceBrowser setDelegate:self];
    [_serviceBrowser searchForServicesOfType:@"_airplay._tcp" inDomain:@""];
}

- (void)setMPButtonSelected:(BOOL)selected
{
    NSString *imageName = selected?_playing:_detected;
    UIImage *image = [UIImage imageNamed:imageName];
    [_mpButton setImage:image forState:UIControlStateNormal];
    [_mpButton setImage:image forState:UIControlStateHighlighted];
    [_mpButton setImage:image forState:UIControlStateSelected];
}
/////////////////////////////////////////////////////////////////////////
- (void)setAirPlayButtonAvailable:(BOOL)available
{
    NSLog(@"%s\t%d",__FUNCTION__,__LINE__);
    
    CGRect frame = CGRectMake(_frame.origin.x-7, _frame.origin.y-2, _frame.size.width, _frame.size.height);
    _volumeView = [[MPVolumeView alloc] initWithFrame:frame];
    [_volumeView setShowsVolumeSlider:NO];
    [self addSubview:_volumeView];
    
    for (id current in _volumeView.subviews){
        if([current isKindOfClass:[UIButton class]]) {
            UIButton *mpButton = (UIButton*)current;
            [mpButton setFrame:_frame];
            
            _mpButton = mpButton;
            [mpButton addObserver:self forKeyPath:@"alpha" options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    
//    [_airPlayButton setHidden:YES];
    
    UIImage *image = [UIImage imageNamed:_detected];
    [_mpButton setImage:image forState:UIControlStateNormal];
    [_mpButton setImage:image forState:UIControlStateHighlighted];
    [_mpButton setImage:image forState:UIControlStateSelected];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSLog(@"%s\t%d",__FUNCTION__,__LINE__);
    NSLog(@"%@",change);
    if (object == _mpButton && [[change valueForKey:NSKeyValueChangeNewKey] intValue] == 1) {
        [self setMPButtonSelected:NO];
    }
}
/////////////////////////////////////////////////////////////////////////

#pragma mark - NetServiceBrowserDelegate Methods
- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didNotSearch:(NSDictionary *)errorDict
{
    NSLog(@"%s\t%d\%@",__FUNCTION__,__LINE__,errorDict);
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    NSLog(@"%s\t%d",__FUNCTION__,__LINE__);
    _isDetected = YES;
    [self setAirPlayButtonAvailable:_isDetected];
    
    [aNetService setDelegate:self];
	[aNetService resolveWithTimeout:20.0];
	[_foundServices addObject:aNetService];
	
	if(!moreComing){
		[_serviceBrowser stop];
		[_serviceBrowser release];
		_serviceBrowser = nil;
	}
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)aNetServiceBrowser
{
    NSLog(@"%s\t%d",__FUNCTION__,__LINE__);
    
}

#pragma mark - NetServiceDelegate Methods
- (void)netServiceDidResolveAddress:(NSNetService *)sender
{
    NSLog(@"Resolved service: %@:%d", sender.hostName, sender.port);
}

@end
#pragma mark - NetServiceBrowser Category End
/////////////////////////////////////////////////////////////////////////
