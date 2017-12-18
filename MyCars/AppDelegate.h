//
//  AppDelegate.h
//  MyCars
//
//  Created by Aeonz on 12/15/17.
//  Copyright © 2017 Aeonz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong , nonatomic) NSManagedObjectContext *context;

- (void)saveContext;


@end

