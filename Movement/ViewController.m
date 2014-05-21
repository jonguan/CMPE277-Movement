//
//  ViewController.m
//  Movement
//
//  Created by Jon Guan on 5/9/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "DataManager.h"

@interface ViewController ()
{
    NSOperationQueue *_stepQueue;
}
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) CMStepCounter *stepCounter;
@property (nonatomic, assign) NSTimeInterval stepTimestamp;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _stepQueue = [[NSOperationQueue alloc] init];
    _stepQueue.maxConcurrentOperationCount = 1;
    
    self.stepCounter = [[CMStepCounter alloc] init];
    self.motionManager = [[CMMotionManager alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startCountingSteps
{
    [self.motionManager startDeviceMotionUpdatesToQueue:_stepQueue withHandler:^(CMDeviceMotion *motion, NSError *error) {
        CMAcceleration userAccel = motion.userAcceleration;
        double x = userAccel.x;
        double y = userAccel.y;
        double z = userAccel.z;
        double mag = sqrt(x * x + y * y + z * z);
        if (mag >= 2 && (motion.timestamp - self.stepTimestamp) > 0.3) {
            self.numSteps ++;
            self.stepTimestamp = motion.timestamp;
            [self updateStepLabel];
        }
    }];
}


- (void)stopCountingSteps
{
    [self.motionManager stopDeviceMotionUpdates];
}


- (IBAction)didClickButton:(UIButton *)sender
{
    if (sender == self.startButton) {
        sender.selected = !sender.selected;
        
        if (sender.selected) {
            [self startCountingSteps];
            
        } else {
            [self stopCountingSteps];
        }
    } else if (sender == self.resetButton) {
        self.numSteps = 0;
        [self updateStepLabel];
    } else if (sender == self.saveButton) {
        [[DataManager sharedManager] saveSteps:self.numSteps withDate:[NSDate date]];
    }
 
}

- (void)updateStepLabel
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.stepsLabel.text = @(self.numSteps).stringValue;
    });
}

@end
