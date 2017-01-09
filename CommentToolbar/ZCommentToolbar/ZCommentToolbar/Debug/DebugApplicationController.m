//
//  DebugApplicationController.m
//  WSCN
//
//  Created by Micker on 16/7/28.
//  Copyright © 2016年 Micker. All rights reserved.
//

#import "DebugApplicationController.h"

NSString * const KROOT_LAUNCHER_IDENTIFIER = @"20000001";

@interface DebugApplicationController()
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, copy  ) NSString       *launcher;

@end

@implementation DebugApplicationController

#pragma mark -- Life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Application";
    self.view.backgroundColor = [UIColor whiteColor];

#ifdef DEBUG
    [self __setup];
#endif
}

- (void) __setup {
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                               target:self
                                                                                               action:@selector(btnClick:)];
        
        self.launcher = [[NSUserDefaults standardUserDefaults] stringForKey:@"launcher"];
        self.launcher = (0 == [self.launcher length]) ? KROOT_LAUNCHER_IDENTIFIER : self.launcher;
    }
    {
        self.data = [NSMutableArray array];
        [self configData];
        self.tableView.tableFooterView = [UIView new];
        [self.tableView reloadData];
    }
}

- (void) configData {
    NSBundle *manager = [NSBundle mainBundle];
    NSString *documentsDirectory = [manager pathForResource:@"MobileRuntime" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:documentsDirectory];
    self.data = [[NSMutableArray alloc] initWithArray:[root objectForKey:@"Applications"]];
}


- (IBAction)btnClick:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.launcher forKey:@"launcher"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    exit(0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *dequeueReusableCellWithIdentifier = @"dequeueReusableCellWithIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dequeueReusableCellWithIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dequeueReusableCellWithIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    NSString *launcher = self.data[indexPath.row][@"name"];

    cell.textLabel.textColor =
    cell.detailTextLabel.textColor = [KROOT_LAUNCHER_IDENTIFIER isEqualToString:launcher] ? [UIColor redColor] : [UIColor blackColor];
    cell.accessoryType = [launcher isEqualToString:self.launcher] ? UITableViewCellAccessoryCheckmark :  UITableViewCellAccessoryNone;
    cell.textLabel.text = [NSString stringWithFormat:@"[%@]%@",@(indexPath.row),self.data[indexPath.row][@"description"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (标号：%@)",self.data[indexPath.row][@"delegate"], launcher];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.launcher = self.data[indexPath.row][@"name"];
    [tableView reloadData];
}

@end
