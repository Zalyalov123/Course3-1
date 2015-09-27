//
//  AppViewController.m
//  Lesson1
//
//  Created by Azat Almeev on 21.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "AppViewController.h"
#import <ReactiveCocoa.h>
#import <KVOMutableArray+ReactiveCocoaSupport.h>
#import <BlocksKit+UIKit.h>
#import "TestViewController.h"
#import "DataController.h"
#import "NewObject.h"

@interface AppViewController ()
{
    NSMutableArray *newArr;
}
//@property (nonatomic, readonly) KVOMutableArray *items;
@end

@implementation AppViewController

- (void)viewDidLoad{
    [super viewDidLoad];
        @weakify(self);
        [[DataController sharedInstance].items.changeSignal subscribeNext:^(RACTuple *tuple) {
            @strongify(self);
            self.title = [NSString stringWithFormat:@"Items count: %@", @([tuple.first count])];
            NSKeyValueChange change = [tuple.second[NSKeyValueChangeKindKey] integerValue];
            NSArray *indices = [tuple.second[NSKeyValueChangeIndexesKey] bk_mapIndex:^id(NSUInteger index) {
                return [NSIndexPath indexPathForItem:index inSection:0];
            }];
            switch (change) {
                case NSKeyValueChangeInsertion:
                    [self.tableView insertRowsAtIndexPaths:indices withRowAnimation:UITableViewRowAnimationAutomatic];
                    break;
                case NSKeyValueChangeRemoval:
                    [self.tableView deleteRowsAtIndexPaths:indices withRowAnimation:UITableViewRowAnimationAutomatic];
                    break;
                case NSKeyValueChangeReplacement:
                    [self.tableView reloadRowsAtIndexPaths:indices withRowAnimation:UITableViewRowAnimationAutomatic];
                    break;
                default:
                    [self.tableView reloadData];
                    break;
            }
        }];
}

- (IBAction)logoutDidPress:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addButtonDidPress:(id)sender {
    [self performSegueWithIdentifier:@"segue" sender:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [DataController sharedInstance].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    NewObject *object = [[DataController sharedInstance] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)object.number];
    cell.detailTextLabel.text = object.text;
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[DataController sharedInstance]deleteObjectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //[self performSegueWithIdentifier:@"segue" sender:indexPath];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]isEqualToString:@"segue"]) {
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TestViewController *vc = segue.destinationViewController;
      //  NewObject *object = [[DataController sharedInstance] itemAtIndex:indexPath.row];
        if (sender) {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            vc.isNew = NO;
            vc.iPath = indexPath.row;
        } else {
            vc.isNew = YES;
        }
    }
}
//- (void)addItemViewController:(TestViewController *)controller didFinishEnteringItem:(NSString *)item{
//    [newArr addObject:item];
//    NSLog(@"%@",item);
//}
- (void)dealloc {
    NSLog(@"%@ deallocated", NSStringFromClass([self class]));
}

@end
