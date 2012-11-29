//
//  WeekAheadViewController.h
//  Time Untill Dark
//
//  Created by Iain Maguire on 17/09/2012.
//  Copyright (c) 2012 Personal Projects. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekAheadCell.h"
#import "TimeTillMainViewController.h"
#import "EDSunriseSet.h"

@interface WeekAheadViewController : UITableViewController {
    
    NSMutableArray* dateArray;
    NSMutableArray* weekAheadArray;
    NSMutableArray* parseDateArray;
    NSMutableArray* sunsetArray;
    NSMutableArray* civilSunsetArray;

    NSArray* weekArray;
    
    NSString * tempDay;
    NSString * sunsetString;
    NSString * civilString;
    NSInteger todayint;
    NSString* dayString;
    
    
    float vcLong;
    float vcLat;
    
    NSDate *vcDate;
    
    TimeTillMainViewController *_timeTill;
    EDSunriseSet* _sunriseSet;

}


@property (strong, nonatomic) TimeTillMainViewController *timeTill;
@property (strong, nonatomic) EDSunriseSet *sunriseSet;

@end
