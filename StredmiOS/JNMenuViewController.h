//
//  JNMenuViewController.h
//  StredmiOS
//
//  Created by Jesus Najera on 3/9/14.
//  Copyright (c) 2014 Stredm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "HomeViewController.h"

@interface JNMenuViewController : UITableViewController <AVAudioPlayerDelegate>

@property (weak, nonatomic) AVPlayerLayer *playerLayer;
@property (nonatomic) float percentageOfSong;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) IBOutlet HomeViewController *hvc;

-(IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue;
-(void)playSongWithQuery:(NSString *)query row:(NSInteger)row;
-(void)playSong:(NSInteger)row;

@end
