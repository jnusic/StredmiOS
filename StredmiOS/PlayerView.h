//
//  PlayerView
//  StredmiOS
//
//  Created by Conner Fromknecht on 3/16/14.
//  Copyright (c) 2014 Stredm. All rights reserved.
//

#import "PlayButton.h"

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "UIImage+ImageEffects.h"

@interface SetListView : UIView

@property (nonatomic, strong) UILabel *label;

@end

@interface PlayerView : UIView <UIScrollViewDelegate, UIToolbarDelegate, UIGestureRecognizerDelegate, NSURLConnectionDataDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIScrollView *songScrollView;
@property (strong, nonatomic) UILabel *currentTimeLabel;
@property (strong, nonatomic) UILabel *durationLabel;
@property (strong, nonatomic) UILabel *songTitleLabel;
@property (strong, nonatomic) PlayButton *playButton;

@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSString *title;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isScrubbing;
@property (nonatomic) BOOL justScrubbed;
@property (nonatomic) BOOL isOpen;

@property (strong, nonatomic) UIImageView *artwork;
@property (strong, nonatomic) UIImageView *background;
@property (strong, nonatomic) UILabel *artistLabel;
@property (strong, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImageView *smallPlayButton;

@property (strong, nonatomic) UIToolbar *playerToolbar;
@property (strong, nonatomic) UIToolbar *bottomToolbar;

@property (strong, nonatomic) UIButton *setList;

@property (strong, nonatomic) UIView *swipeDownView;

@property (strong, nonatomic) NSMutableArray *playlistArray;
@property (nonatomic) NSInteger currentRow;

@property (strong, nonatomic) NSURL *setURL;
@property (strong, nonatomic) NSURL *imageURL;

@property (strong, nonatomic) UILabel* addedSong;

@property (strong, nonatomic) NSMutableArray* tracklist;
@property (strong, nonatomic) NSMutableArray* startTimes;

-(void)openPlayer:(CGSize)size;
-(void)closePlayer;

-(void)playSong:(NSInteger)row;
-(void)random;

-(void)playPush:(id)sender;

-(void)play;
-(void)pause;
-(void)next;
-(void)previous;

-(void)updateLockscreen;

@end
