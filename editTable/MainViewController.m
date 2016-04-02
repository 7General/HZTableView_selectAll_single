//
//  MainViewController.m
//  editTable
//
//  Created by 王会洲 on 16/4/1.
//  Copyright © 2016年 王会洲. All rights reserved.
//
#define YSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#import "MainViewController.h"
#import "SelectCell.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * editTableView;


@property (nonatomic, strong) NSDictionary * sectionData;
@property (nonatomic, strong) NSArray * editData;


@property (nonatomic, strong) UIButton * ButtonEdit;

/**
 *  统计button
 */
@property (nonatomic, strong) UIButton * ResultButton;


@property (nonatomic, strong) NSMutableArray * selectArry;
@end

@implementation MainViewController


-(NSMutableArray *)selectArry {
    if (_selectArry == nil) {
        _selectArry = [NSMutableArray new];
    }
    return _selectArry;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"表格编辑";
    
    self.editData = @[@"1月",@"2月",@"3月"];
    self.sectionData = @{@"1月" : @[@"1",@"2",@"3",@"4",@"2",@"3"],@"2月" : @[@"1",@"2",@"3",@"2"],@"3月" : @[@"3",@"4",@"2",@"3"]}.mutableCopy;
    self.editTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.editTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.editTableView.delegate = self;
    self.editTableView.dataSource = self;
    [self.view addSubview:self.editTableView];
    
    /**
     *  编辑按钮
     */
    self.ButtonEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ButtonEdit.backgroundColor = [UIColor redColor];
    [self.ButtonEdit setTitle:@"编辑" forState:UIControlStateNormal];
    [self.ButtonEdit addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    self.ButtonEdit.frame = CGRectMake(200, 600, 100, 50);

    [self.ButtonEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self.view addSubview:self.ButtonEdit];
    
    
    
    /**
     *  统计按钮
     */
    self.ResultButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ResultButton.backgroundColor = [UIColor redColor];
    [self.ResultButton setTitle:@"统计" forState:UIControlStateNormal];
    [self.ResultButton addTarget:self action:@selector(resultClickAction) forControlEvents:UIControlEventTouchUpInside];
    self.ResultButton.frame = CGRectMake(200, 400, 100, 50);
    [self.ResultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    [self.view addSubview:self.ResultButton];
    
    
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllCell)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消全选" style:UIBarButtonItemStylePlain target:self action:@selector(CancelselectAllCell)];
    
    
}

-(void)resultClickAction {
    NSLog(@"统计---%ld",self.selectArry.count);
    for (NSIndexPath * path in self.selectArry) {
        NSLog(@"统计结果：--->>>section%ld-----row%ld",path.section,path.row);
    }
}



-(void)CancelselectAllCell {
  NSLog(@"取消全选");
  [self.selectArry removeAllObjects];
    // 获取所有的section
    NSInteger sectionCount = self.editData.count;
    // 获取所有cell的indexpath
    for (NSInteger Sectionindex = 0; Sectionindex < sectionCount; Sectionindex++) {
        NSString * keyStr = self.editData[Sectionindex];
        NSInteger cellCount = [self.sectionData[keyStr] count];
        for (NSInteger indexCell = 0; indexCell < cellCount; indexCell++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:indexCell inSection:Sectionindex];
            SelectCell *cell = (SelectCell*)[self.editTableView cellForRowAtIndexPath:indexPath];
            [cell CancelsetselectButtonSeleted:cell.selectButton];
        }
    }
    
    
}
-(void)selectAllCell {
    [self.selectArry removeAllObjects];
    [self allSelect];
    NSLog(@"-----<<<<%ld",self.selectArry.count);
}


- (void)allSelect{
    
    // 获取所有的section
    NSInteger sectionCount = self.editData.count;
    // 获取所有cell的indexpath
    for (NSInteger Sectionindex = 0; Sectionindex < sectionCount; Sectionindex++) {
        NSString * keyStr = self.editData[Sectionindex];
        NSInteger cellCount = [self.sectionData[keyStr] count];
        for (NSInteger indexCell = 0; indexCell < cellCount; indexCell++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:indexCell inSection:Sectionindex];
            [self.selectArry addObject:indexPath];
            SelectCell *cell = (SelectCell*)[self.editTableView cellForRowAtIndexPath:indexPath];
            [cell setselectButtonSeleted:cell.selectButton];
        }
    }
    
}


-(void)editAction {
    [self editTableView:!self.editTableView.editing WithAnimate:YES];
}

#pragma mark - 编辑表格动作
-(void)editTableView:(BOOL)editing WithAnimate:(BOOL)animate {
    
    [self.editTableView setEditing:editing animated:animate];
    
    [self editLeftLine:editing Animate:YES];
}



/**
 *  控制section的竖线
 */
 -(void)editLeftLine:(BOOL)edit Animate:(BOOL)animate {
    // section 头部竖线
     
     [self.editData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         UIView * headView = [self.editTableView viewWithTag:3000 + idx];
         if (!headView) {
             *stop = NO;
         }
         UIView * headLine  = [headView viewWithTag:2000];
         CGPoint headCenter = headLine.center;
         if (edit) {
             headCenter.x = -20;
         }else {
             headCenter.x = 20;
         }
         [UIView animateWithDuration:0.25 animations:^{
             headLine.center = headCenter;
         }];
     }];
}


#pragma mark - TABLEVIEW DELEGATE
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.editData.count;
}

/**
 *  获取section的View的视图
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 10, 10)];
    sectionView.tag = 3000 + section;
    sectionView.backgroundColor = [UIColor grayColor];
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
    titleView.text = self.editData[section];
    [sectionView addSubview:titleView];
    
    
    UIView * lineOne = [[UIView alloc] init];
    if (self.editTableView.editing) {
        lineOne.center = CGPointMake(-20, 20);
        lineOne.bounds = CGRectMake(0, 0, 1, 40);
    }
    else {
        lineOne.center = CGPointMake(20, 20);
        lineOne.bounds = CGRectMake(0, 0, 1, 40);
    }
    lineOne.backgroundColor = [UIColor redColor];
    lineOne.tag = 2000;
    [sectionView addSubview:lineOne];
    
    return sectionView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     NSString * keyStr = self.editData[section];
    NSArray * arryContent = self.sectionData[keyStr];
    return arryContent.count;
}
/**
 *  cell内容
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectCell * cell = [SelectCell cellWithTableView:tableView];
    NSString * keyStr = self.editData[indexPath.section];

    NSString * titleLabel = ((NSArray *)self.sectionData[keyStr])[indexPath.row];
    cell.titleLabel.text  = titleLabel;
    cell.selectButton.selected = ([self.selectArry indexOfObject:indexPath] != NSNotFound);
    // 选中按钮
    cell.selectButtonClick = ^(UIButton * btn) {
        [btn setSelected:!btn.selected];
        id view = [btn superview];
        NSIndexPath * indexPath = [self.editTableView indexPathForCell:view];
        if (btn.selected) {
            if ([self.selectArry indexOfObject:indexPath] == NSNotFound) {
                [self.selectArry addObject:indexPath];
            }
        }else {
            if ([self.selectArry indexOfObject:indexPath] != NSNotFound) {
                [self.selectArry removeObject:indexPath];
            }
        }
    };
    
    
    return cell;
}

/**
 *  控制行高
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}


@end