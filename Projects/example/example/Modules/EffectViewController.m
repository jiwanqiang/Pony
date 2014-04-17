//
//  EffectViewController.m
//  example
//
//  Created by Wanqiang Ji on 4/16/14.
//  Copyright (c) 2014 http://jiwanqiang.com. All rights reserved.
//

#import "EffectViewController.h"

static NSString *kEffectCellIdentifier = @"com.stupk.cell.effect";

@interface EffectViewController ()

@property (nonatomic, strong) NSMutableArray *effectArray;

@end

@implementation EffectViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.effectArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Effect Set", @"效果集合");
    Class cls = [UITableViewCell class];
    [self.tableView registerClass:cls forCellReuseIdentifier:kEffectCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)idp
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEffectCellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"Effect %02d", idp.row + 1];
    return cell;
}

@end
