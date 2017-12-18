//
//  TableViewController.h
//  MyCars
//
//  Created by Aeonz on 12/15/17.
//  Copyright © 2017 Aeonz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TableViewController : UITableViewController
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}
@end
