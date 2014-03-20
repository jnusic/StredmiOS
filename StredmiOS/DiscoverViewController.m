//
//  DiscoverViewController.m
//  StredmiOS
//
//  Created by john on 3/18/14.
//  Copyright (c) 2014 Stredm. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@property (nonatomic) NSInteger currentMode;

@property (strong, nonatomic) NSArray *recentArray;
@property (strong, nonatomic) NSArray *featuredArray;
@property (strong, nonatomic) NSArray *popularArray;

@end

@implementation DiscoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.currentMode = (NSInteger)self.discoverSegCont.selectedSegmentIndex;
        [self.discoverSegCont addTarget:self action:@selector( changeDiscoverMode ) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}


#pragma mark - Table view data source

-(NSData *)dataFromURL:(NSString *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if ( error != nil ) [NSException raise:@"Error retrieving data" format:@"Could not reach %@", url];
    return data;
}

-(NSArray *)safeJSONParseArray:(NSString *)url {
    NSArray *array = nil;
    NSData *data = nil;
    @try {
        data = [self dataFromURL:url];
    }
    @catch (NSException *exception) {
        data = nil;
    }
    @finally {
        NSError *error;
        array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if ( error != nil ) array = [NSArray arrayWithObjects:@"An error occured", nil];
        return array;
    }
}

- (void)changeDiscoverMode {
    self.currentMode = (NSInteger)self.discoverSegCont.selectedSegmentIndex;
    [self.tableView reloadData];
}


-(NSArray *)recentArray {
    if ( _recentArray != nil ) return _recentArray;
    NSString *searchURL = @"http://stredm.com/scripts/mobile/recent.php";
    _recentArray = [self safeJSONParseArray:searchURL];
    return _recentArray;
}

-(NSArray *)featuredArray {
    if ( _featuredArray != nil ) return _featuredArray;
    NSString *featuredURL = @"http://stredm.com/scripts/mobile/featured.php";
    _featuredArray = [self safeJSONParseArray:featuredURL];
    return _featuredArray;
}

-(NSArray *)popularArray {
    if ( _popularArray != nil ) return _popularArray;
    NSString *popularURL = @"http://stredm.com/scripts/mobile/popular.php";
    _popularArray = [self safeJSONParseArray:popularURL];
    return _popularArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentMode = (NSInteger)self.discoverSegCont.selectedSegmentIndex;
    [self.discoverSegCont addTarget:self action:@selector( changeDiscoverMode ) forControlEvents:UIControlEventValueChanged];
    
    
    //    [self.tableView registerClass: [BrowseTableCell class] forCellReuseIdentifier:@"BrowseTableCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // UIImage *segmentedBackground = [UIImage imageNamed:@"GearImage.png"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        switch (self.currentMode) {
            case 0:
                return [self.recentArray count];
            case 1:
                return [self.featuredArray count];
            case 2:
                return [self.popularArray count];
            default:
                return 0;
        }
        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DiscoverTableCell";
    DiscoverTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //    if ( cell == nil ) {
    //        cell = [[BrowseTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    //    }
    
    switch (self.currentMode) {
        case 0:
            cell.textLabel.text = [[self.recentArray objectAtIndex:indexPath.row] objectForKey:@"event"];
            cell.idNum = (NSInteger)[[self.recentArray objectAtIndex:indexPath.row] objectForKey:@"id"];
            break;
        case 1:
            cell.textLabel.text = [[self.featuredArray objectAtIndex:indexPath.row] objectForKey:@"event"];
            cell.idNum = (NSInteger)[[self.featuredArray objectAtIndex:indexPath.row] objectForKey:@"id"];
            break;
        case 2:
            cell.textLabel.text = [[self.popularArray objectAtIndex:indexPath.row] objectForKey:@"event"];
            cell.idNum = (NSInteger)[[self.popularArray objectAtIndex:indexPath.row] objectForKey:@"id"];
            break;
        default:
            cell.textLabel.text = @"An error occured";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:indexPath.row forKey:@"row"];
    switch (self.currentMode) {
        case 0:
            [defaults setObject:self.recentArray forKey:@"playlist"];
            break;
        case 1:
            [defaults setObject:self.featuredArray forKey:@"playlist"];
            break;
        case 2:
            [defaults setObject:self.popularArray forKey:@"playlist"];
            break;
        default:
            break;
    }
    [defaults synchronize];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
