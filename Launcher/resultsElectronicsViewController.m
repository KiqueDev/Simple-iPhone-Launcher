//
//  resultsElectronicsView.m
//  BCLibrary
//
//  Created by Enrique W on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "resultsElectronicsViewController.h"
#import "resourceResultElectronicView.h"

@implementation resultsElectronicsViewController
@synthesize subjectID, libraryID;
@synthesize listOfItems;
@synthesize eResParser;

@synthesize cListOfItems;
@synthesize searchArray;
@synthesize resResultController;

-(void) eResParserDidFinishParsing: (ElectronicResParser *) parser{
    
    NSLog(@"parsing \"Electronic Resources\" complete!");
}


-(void)sendData:(NSString*)subID withLibID:(NSString *)libID withResDic:(ElectronicResParser *)eRP{
    subjectID= subID;
    
    eResParser=eRP;
    
    libraryID=libID;
    subIDLabel.text= [NSString stringWithFormat:@"Subject_ID is %@... Library ID is %@", subjectID, libraryID];
}
- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
    
    //CGRect CellFrame = CGRectMake(0, 0, 300, 60);
    CGRect Label1Frame = CGRectMake(10, 0, 290, 40);
    CGRect Label2Frame = CGRectMake(10, 40, 290, 70);
    UILabel *lblTemp;
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    
    //Initialize Label with tag 1.
    lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
    lblTemp.tag = 1;
    [cell.contentView addSubview:lblTemp];
    [lblTemp release];
    
    //Initialize Label with tag 2.
    lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
    lblTemp.tag = 2;
    lblTemp.font = [UIFont boldSystemFontOfSize:12];
    lblTemp.textColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:lblTemp];
    
    [lblTemp release];
    
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
//Search animations
- (void)showSearch:(id)sender {
    //toggle visibility of the search bar
    [self setSearchVisible:(resSearchBar.alpha != 1.0)];
    //Hide the keyboard if search button clicked
    [resSearchBar resignFirstResponder];
}
- (void)setSearchVisible:(BOOL)visible {
    UIView *mainView = rTableView; // set this to whatever your non-searchBar view is
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:UINavigationControllerHideShowBarDuration];
    if (!visible) {
        resSearchBar.alpha = 0.0;
        CGRect frame = mainView.frame;
        frame.origin.y = 0;
        frame.size.height += resSearchBar.bounds.size.height;
        mainView.frame = frame;
    } else {
        resSearchBar.alpha = 1.0;
        CGRect frame = mainView.frame;
        frame.origin.y = resSearchBar.bounds.size.height;
        frame.size.height -= resSearchBar.bounds.size.height;
        mainView.frame = frame;
    }
    [UIView commitAnimations];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //setSearchView to false(hide search bar) when view loads
    [self setSearchVisible:FALSE];
    
    //The Search button on top right
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemSearch 
                                               target:self
                                               action:@selector(showSearch:)] autorelease];
    
    //Set search bar color to redwine
    UIColor *myColor= [UIColor colorWithRed:90.0/255.0 green:23.0/255.0 blue:43.0/255.0 alpha:1.0];
    [resSearchBar setTintColor:myColor];

    
    //NSLog(@"%@",[[cListOfItems objectAtIndex:0] objectForKey:@"Resources"] );
    
    //NSLog(@"%@",[cListOfItems valueForKey:@"Resources"] );
    
    //NSLog(@"%@", [listOfItems valueForKey:@"Resources"] );
    //NSLog(@"%@",[[[eResParser.resCatDic objectForKey:@"Top Picks"] objectForKey:@"Beginner's Guide to Business Research Using Company Websites"] objectForKey:@"Descrip"]);


    //NSLog(@"%@",eResParser.catList);
    //NSLog(@"%@",eResParser.resCatDic);

  //NSLog(@"%@", listOfItems);
 
}

//Keyboard hide stuffs when yu click on cancel button and search button
- (void)searchBarSearchButtonClicked:(UISearchBar *)asearchBar{
    [asearchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)asearchBar{
    [asearchBar resignFirstResponder];
}
//If scroll on table view the keyboard dissapears
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
//Make the keyboard from search go away when the view dissapears
-(void)viewDidDisappear:(BOOL)animated{
    [resSearchBar resignFirstResponder];
    resSearchBar.text = @"";
}

//allocate everything before view starts
-(void)viewWillAppear:(BOOL)animated{
    subIDLabel.text= [NSString stringWithFormat:@"Subject_ID is %@... Library ID is %@", subjectID, libraryID];
    
    listOfItems = [[NSMutableArray alloc] init];
    
    for(NSString *obj in eResParser.catList){
        NSMutableArray *resArray = [[NSMutableArray alloc] init];
        for (NSString *resStr in [eResParser.resCatDic valueForKey:obj]) {
            [resArray addObject:resStr];
        }
        
        //alphabetical order
        NSDictionary *catDic = [NSDictionary dictionaryWithObject:[resArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] forKey:@"Resources"];
        [ listOfItems addObject:catDic ];
        
    }
    
    //Initialize the copy array.
    cListOfItems = [[NSMutableArray alloc] initWithArray:listOfItems];
    
    searchArray = [[NSMutableArray alloc] init];    
    for (NSDictionary *dictionary in cListOfItems){
        NSArray *array = [dictionary objectForKey:@"Resources"];
        [searchArray addObjectsFromArray:array];
        
    }
 
    //Reload the table data
    [rTableView reloadData];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    NSMutableArray *stringArr= [[NSMutableArray alloc] init];
    if([searchText length] == 0) {
        [listOfItems removeAllObjects];
        [listOfItems addObjectsFromArray:cListOfItems];
    }
    else {
        [listOfItems removeAllObjects];
        for(NSString *string in searchArray){
            NSRange r= [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(r.location != NSNotFound){
                [stringArr addObject:string];
            }
        }
        //set the resources stuff on the corresponding place
        for(NSString *obj in eResParser.catList){
            NSMutableArray *resArray = [[NSMutableArray alloc] init ];
            for (NSString *resStr in [eResParser.resCatDic valueForKey:obj]) {
                for(NSString *str in stringArr){
                    if([str isEqualToString:resStr])
                        [resArray addObject:str];
                }
            }
            //alphabetical order
            NSDictionary *catDic = [NSDictionary dictionaryWithObject:[resArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] forKey:@"Resources"];
            [ listOfItems addObject:catDic ];
            
            [resArray release];
        }
    }
    //NSLog(@"%@", listOfItems);
    [stringArr release];
    [rTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [listOfItems count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [eResParser.catList objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        //Number of rows it should expect should be based on the section
        NSDictionary *dictionary = [listOfItems objectAtIndex:section];
        NSArray *array = [dictionary objectForKey:@"Resources"];
        return [array count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Make the Highlight row color go away
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    //Check to see if the controller is nill or not.
    if (resResultController == nil) {
        
        //Initialize the detail view controller and display it.
        resourceResultElectronicView *aController = [[resourceResultElectronicView alloc] initWithNibName:@"resourceResultElectronicView" bundle:[NSBundle mainBundle]];
        
        //Set the Controller to our variable
        self.resResultController= aController;
        
        //Release the temp controller
        [aController release];
    }
    NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Resources"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    
    [resResultController sendData:cellValue withResURL:[[[eResParser.resCatDic objectForKey:[eResParser.catList objectAtIndex:indexPath.section]] objectForKey:cellValue] objectForKey:@"URL"] withResDesc:[[[eResParser.resCatDic objectForKey:[eResParser.catList objectAtIndex:indexPath.section]] objectForKey:cellValue] objectForKey:@"Descrip"]];
    
    [[self navigationController]pushViewController:resResultController animated:YES];
    
}
//Function to convert the subView "Description" on the tableView
- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

/*Disclouse events
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"disclosure button touched"); 
}
*/

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell= [rTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell = [self getCellContentView:CellIdentifier];
        //disable the click on the cell 
        //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        //light table row with red wine color
        UIView *v = [[[UIView alloc] init] autorelease];
        UIColor *myColor= [UIColor colorWithRed:128.0/255.0 green:0 blue:0 alpha:1.0];
        v.backgroundColor = myColor;
        cell.selectedBackgroundView = v;
    }
    

    UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
    UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
    
    NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Resources"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];

    
    //Get the Descrip from the resCatDic...
    //NSLog(@"%@",[[[eResParser.resCatDic objectForKey:[eResParser.catList objectAtIndex:indexPath.section]] objectForKey:cellValue] objectForKey:@"Descrip"]);
    
    //change font size of the table cell
    //cell.textLabel.font = [UIFont systemFontOfSize:12.0];    
    lblTemp1.text = cellValue;
    lblTemp1.numberOfLines = 2;
	lblTemp1.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:lblTemp1];
    lblTemp2.text = [self flattenHTML:[[[eResParser.resCatDic objectForKey:[eResParser.catList objectAtIndex:indexPath.section]] objectForKey:cellValue] objectForKey:@"Descrip"]];
    lblTemp2.numberOfLines = 2;
    lblTemp2.numberOfLines = 3;
    lblTemp2.numberOfLines = 4;
    [cell.contentView addSubview:lblTemp2];
    

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [subIDLabel release];
    [subjectID release];
    [libraryID release];
    [rTableView release];
    [listOfItems release];
    [cListOfItems release];

    [resSearchBar release];
    [searchArray release];
    
    [eResParser release];
    
    [resResultController release];

}

@end
