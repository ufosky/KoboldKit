//
//  SKTAudio.m
//  SKTUtils
//
//  Created by Main Account on 6/24/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "SKTAudio.h"

@interface SKTAudio()
@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;
@end

@implementation SKTAudio

+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static SKTAudio * _sharedInstance;
    dispatch_once(&pred, ^{ _sharedInstance = [[self alloc] init]; });
    return _sharedInstance;
}

- (void)playBackgroundMusic:(NSString *)filename {
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
}

- (void)pauseBackgroundMusic
{
    [self.backgroundMusicPlayer pause];
}

- (void)resumeBackgroundMusic
{
    [self.backgroundMusicPlayer play];
}

@end
