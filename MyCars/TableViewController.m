//
//  TableViewController.m
//  MyCars
//
//  Created by Aeonz on 12/15/17.
//  Copyright © 2017 Aeonz. All rights reserved.
//

#import "TableViewController.h"
#import "AddCarViewController.h"

@interface TableViewController ()
@property (strong , nonatomic) NSMutableArray *cars;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]initWithEntityName:@"Vehicle"];
    self.cars = [[context executeFetchRequest:fetchrequest error:nil]mutableCopy];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cars count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSManagedObjectModel *aCar = [self.cars objectAtIndex:indexPath.row];
    
    //combine make and model into a string
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@" , [aCar valueForKey:@"make"] , [aCar valueForKey:@"model"]]];
    
    // convert db to string to display
    NSString *year = [NSString stringWithFormat:@"%@" , [aCar valueForKey:@"year"]];
    [cell.detailTextLabel setText:year];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [context deleteObject:[self.cars objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@ %@" , error , [error localizedDescription]);
        }
        [self.cars removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([[segue identifier] isEqualToString:@"updateCar"]){
         // Pass the selected object to the new view controller.
        NSManagedObjectModel *selectedCar = [self.cars objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        AddCarViewController *updateCarView = segue.destinationViewController;
        updateCarView.aCar = selectedCar;
        
    }
    
   
}


@end
