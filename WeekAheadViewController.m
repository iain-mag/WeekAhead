//
//  WeekAheadViewController.m
//  Time Untill Dark
//
//  Created by Iain Maguire on 17/09/2012.
//  Copyright (c) 2012 Personal Projects. All rights reserved.
//

#import "WeekAheadViewController.h"

@interface WeekAheadViewController ()

@end

@implementation WeekAheadViewController

@synthesize timeTill = _timeTill;
@synthesize sunriseSet = _sunriseSet;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    _timeTill = [[TimeTillMainViewController alloc] init];
    TimeTillMainViewController *vc = [self.tabBarController.viewControllers objectAtIndex:1];
    
    todayint = vc.dayInt; 
    vcLong = vc.CLlong;
    vcLat = vc.CLlat;
    vcDate = vc.CLDate;

    NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
    _sunriseSet = [[EDSunriseSet alloc] initWithTimezone:(NSTimeZone *)localTimeZone latitude:vcLat longitude:vcLong];  

    [self dayWeek : todayint];
    
    
}

-(NSString*)calculateSunset : (NSDate*)dateVal{
    
    [_sunriseSet calculate:(NSDate*)dateVal];
    NSDate* date = [[NSCalendar currentCalendar] dateFromComponents:[_sunriseSet localSunset]];
    NSString* sunsetSt = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];   
    return sunsetSt;
    
} 

-(NSString*)calculateCivil : (NSDate*)dateVal{
    
    [_sunriseSet calculate:(NSDate*)dateVal];
    NSDate* date = [[NSCalendar currentCalendar] dateFromComponents:[_sunriseSet localCivilTwilightEnd]];
    NSString* civilSunsetString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    
    return civilSunsetString;
    
} 

-(NSMutableArray*)sevenDays : (NSDate*)today 

{    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    dateArray = [[NSMutableArray alloc] init];   
    [dateArray addObject:today];
    
    for (int i = 1; i < 7 ;i++) {
        
        [offsetComponents setDay:i];
        NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
        [dateArray addObject:nextDate];

    }

    return dateArray;
}


-(void) dayWeek : (NSInteger) day {
    NSDate *today = [NSDate date];
    parseDateArray = [[NSMutableArray alloc] init];
    sunsetArray = [[NSMutableArray alloc] init];
    civilSunsetArray = [[NSMutableArray alloc] init];  
    dateArray = [self sevenDays:today];
    NSLog(@"dateArray %@", dateArray);

    for (int i = 0; i < 7; i++) {
        NSString * formattedDate = [[dateArray objectAtIndex:i]description];
        NSLog(@"formattedDate %@", formattedDate);
        [parseDateArray addObject: [_timeTill parseDate : formattedDate]];
        [sunsetArray addObject: [self calculateSunset:[parseDateArray objectAtIndex:i]]];
        [civilSunsetArray addObject: [self calculateCivil:[parseDateArray objectAtIndex:i]]];

    }
  
    weekArray= [NSArray arrayWithObjects:@"Blank", @"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday",  nil];
    weekAheadArray = [[NSMutableArray alloc] init];   
  
       for (int i = 0; i < 7; i++)
    {
 
        tempDay = [weekArray objectAtIndex:day];   
        [weekAheadArray addObject:tempDay];
       
        day++;
        
        if(day > 7)
            day = 1;
    }
    
   } 


- (void)viewDidLoad

{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{

      [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    WeekAheadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    switch (indexPath.row) {
        case 0:
            dayString = @"Today";
            break;
            
        default:
            dayString = [weekAheadArray objectAtIndex:indexPath.row];
            break;
    }
  
    [cell setDayText:dayString];
    [cell setSunsetText:[sunsetArray objectAtIndex:indexPath.row]];
    [cell setDarkText:[civilSunsetArray objectAtIndex:indexPath.row]];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

// TODO
    
}

@end
