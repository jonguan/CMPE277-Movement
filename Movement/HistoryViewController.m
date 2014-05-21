//
//  HistoryViewController.m
//  Movement
//
//  Created by Jon Guan on 5/11/14.
//  Copyright (c) 2014 Scanadu, Inc. All rights reserved.
//

#import "HistoryViewController.h"
#import "DataManager.h"
#import "StepEntity.h"

static NSDateFormatter *dateFormatter = nil;

@interface HistoryViewController ()
@property (nonatomic, strong) NSFetchedResultsController *resultsController;
@end

@implementation HistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupResultsController];
    
    [self setupDateFormatter];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupDateFormatter
{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss "];
    dateFormatter.doesRelativeDateFormatting = YES;
    
}

- (void)setupResultsController
{
    NSFetchRequest *fetchRequest     = [[NSFetchRequest alloc] initWithEntityName:@"StepEntity"];
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [fetchRequest setSortDescriptors:@[dateDescriptor]];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"profile.name like %@", self.currentUser.name];
//    [fetchRequest setPredicate:predicate];
    
    NSManagedObjectContext *context = [DataManager sharedManager].managedObjectContext;
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];

    NSError *error;
    [self.resultsController performFetch:&error];
    

}

#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    if ([[self.resultsController sections] count] > 0) {
        NSArray *sections = self.resultsController.sections;
        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"stepCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    StepEntity *entity = [self.resultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = entity.steps.stringValue;
//    NSString *dateTime = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:entity.date], [dateFormatter] ];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:entity.date];
    return cell;
}


@end
