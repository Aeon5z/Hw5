//
//  AddCarViewController.m
//  MyCars
//
//  Created by Aeonz on 12/15/17.
//  Copyright © 2017 Aeonz. All rights reserved.
//

#import "AddCarViewController.h"
#import "Vehicle+CoreDataClass.h"


@interface AddCarViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtMake;
@property (weak, nonatomic) IBOutlet UITextField *txtModel;
@property (weak, nonatomic) IBOutlet UITextField *txtYear;
@property (weak, nonatomic) IBOutlet UITextField *txtMPG;

@end

@implementation AddCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    
    if (self.aCar) {
        self.txtMake.text = [self.aCar valueForKey:@"make"];
        self.txtModel.text = [self.aCar valueForKey:@"model"];
        
        // get the year from db and convert it to a string
        NSNumber *numericYear = [self.aCar valueForKey:@"year"];
        NSString *year = [NSString stringWithFormat:@"%@" , numericYear];
        self.txtYear.text = year;
        
        // get the mpg from db and convert it to a string
        NSNumber *numericMPG = [self.aCar valueForKey:@"mpg"];
        NSString *MPG = [NSString stringWithFormat:@"%@" , numericMPG];
        self.txtMPG.text = MPG;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)saveRecord:(UIButton *)sender {
    NSNumberFormatter *f = [[NSNumberFormatter alloc]init];
    
    //existing car update
    if (self.aCar) {
        [self.aCar setValue:self.txtMake.text forKey:@"make"];
        [self.aCar setValue:self.txtModel.text forKey:@"model"];
        
        // convert the year from string to a number and stores it
        NSNumber *myYear = [f numberFromString:self.txtYear.text];
        [self.aCar setValue:myYear forKey:@"year"];
        
        // convert the mpg from string to a number and stores it
        NSNumber *myMPG = [f numberFromString:self.txtMPG.text];
        [self.aCar setValue:myMPG forKey:@"mpg"];
    }
    else {
        // new car
        Vehicle *myCar = [[Vehicle alloc]initWithContext:context];
        [myCar setValue:self.txtMake.text forKey:@"make"];
        [myCar setValue:self.txtModel.text forKey:@"model"];
        
        // format integer
        [f setNumberStyle:NSNumberFormatterNoStyle];
        NSNumber *myYear = [f numberFromString:self.txtYear.text];
        [myCar setValue:myYear forKey:@"year"];
        
        // format decimial
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *myMPG = [f numberFromString:self.txtMPG.text];
        [myCar setValue:myMPG forKey:@"mpg"];
    }
    //zero out the fields
    self.txtMake.text = @"";
    self.txtModel.text = @"";
    self.txtYear.text = @"";
    self.txtMPG.text = @"";
    
    //commit
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"%@ %@" , error , [error localizedDescription]);
    }
    
    // dismiss the view
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dismissKeyboard:(id)sender {
    
}


@end
