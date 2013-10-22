//
//  VCBook.m
//  Kaoyaya
//
//  Created by Goven on 13-10-14.
//  Copyright (c) 2013年 Goven. All rights reserved.
//

#import "VCBook.h"
#import "OrderItem.h"

@interface VCBook () {
    NSArray *_items;
    NSArray *_keys;
}

@end

@implementation VCBook

@synthesize orderItem = _orderItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    _items = [NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", nil];
    _keys = [NSArray arrayWithObjects:@"A", @"B", @"C", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _keys.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_keys == 0) {
        return nil;
    }
    NSString * key = [_keys objectAtIndex:section];
    return key;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSString * message = [[NSString alloc]initWithFormat:@"You selected is %@!",[_items objectAtIndex:row]];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Information" message:message delegate:nil cancelButtonTitle:@"Confirm" otherButtonTitles:nil,nil];
    [alert show];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bookCell"];
    UILabel *title = (UILabel *)[cell viewWithTag:1];
    UILabel *detail = (UILabel *)[cell viewWithTag:2];
    title.text = [_items objectAtIndex:row];
    detail.text = [_items objectAtIndex:row];
    cell.detailTextLabel.text = [_items objectAtIndex:row];
    return cell;
}

@end
