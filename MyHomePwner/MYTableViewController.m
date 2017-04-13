//
//  MYTableViewController.m
//  MyHomePwner
//
//  Created by hc on 2017/3/6.
//  Copyright © 2017年 hc. All rights reserved.
//

#import "MYTableViewController.h"
#import "MYItem.h"
#import "MYItemStore.h"
#import "MYItemCell.h"
#import "MYImageStore.h"
#import "MYDetailViewController.h"

#import "MYImageViewController.h"
@interface MYTableViewController ()

@end

@implementation MYTableViewController
//- (instancetype)init {
//    self = [super initWithStyle:UITableViewStylePlain];
//    if (self) {
//        UINavigationItem *navItem = self.navigationItem;
//        navItem.title = @"Homepwner";
//        
//        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
//        navItem.rightBarButtonItem = bbi;
//        navItem.leftBarButtonItem = self.editButtonItem;
//
//    }
//    return self;
//}
- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
        
    }
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MYItemCell" bundle:nil] forCellReuseIdentifier:@"MYItemCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)editAction:(id)sender {
    if (self.isEditing) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }

}
- (void)addAction:(id)sender {
//    MYItem *newItem = [[MYItemStore sharedStore] createItem];
//    NSInteger lastRow = [[[MYItemStore sharedStore] allItems] indexOfObject:newItem];
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
//    
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    
    //create a new MYItem and add it to the store
    MYItem *newItem = [[MYItemStore sharedStore] createItem];
    MYDetailViewController *detailVC = [[MYDetailViewController alloc] initForNewItem:YES];
    detailVC.item = newItem;
    detailVC.dismissBlock = ^{
        [self.tableView reloadData];
    };
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailVC];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:NULL];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[MYItemStore sharedStore] allItems] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
//    
//    NSArray *items = [[MYItemStore sharedStore] allItems];
//    MYItem *item = items[indexPath.row];
//    cell.textLabel.text = [item description];
    
    MYItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYItemCell" forIndexPath:indexPath];
    
    NSArray *items = [[MYItemStore sharedStore] allItems];
    MYItem *item = items[indexPath.row];
    
    cell.nameLabel.text = item.name;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d",item.valueInDollars];
    cell.thumbnailView.image = item.thumbnail;
    
    cell.tapImageBlock = ^{
        NSLog(@"wa haha");
        
        NSString *itemKey = item.itemKey;
        UIImage *image = [[MYImageStore sharedStore] imageForKey:itemKey];
        
        if (!image) {
            NSLog(@"No image");
            return ;
        }
        
        MYImageViewController *vc = [[MYImageViewController alloc] init];
        vc.image = image;
        [self presentViewController:vc animated:YES completion:nil];
    };
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSArray *items = [[MYItemStore sharedStore] allItems];
        MYItem *item = items[indexPath.row];
        [[MYItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[MYItemStore sharedStore] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MYDetailViewController *detailVC = [[MYDetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[MYItemStore sharedStore] allItems];
    MYItem *selectedItem = items[indexPath.row];
    
    detailVC.item = selectedItem;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}





@end
