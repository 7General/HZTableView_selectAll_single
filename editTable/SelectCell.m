//
//  SelectCell.m
//  editTable
//
//  Created by 王会洲 on 16/4/1.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "SelectCell.h"

@interface SelectCell ()
// 细线
@property (nonatomic, strong) UIView * lineOne;

@property (nonatomic, strong) UIView * conView;




@property (nonatomic, strong) UIView * backGroundView;

@end


@implementation SelectCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString * ID = @"cell";
    SelectCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell== nil) {
        cell = [[SelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}


-(void)initView {
    
   
    
    // 内容view
    UIView * conView = [[UIView alloc] initWithFrame:CGRectMake(40, 1, 300, 78)];
    conView.layer.borderColor = [UIColor grayColor].CGColor;
    conView.layer.cornerRadius = 5;
    conView.layer.borderWidth = 1;
    conView.layer.masksToBounds = YES;
    [self.contentView addSubview:conView];
    self.conView = conView;
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
    self.titleLabel = titleLabel;
    [conView addSubview:self.titleLabel];
    
    UIView * lineTwo = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 1, 80)];
    lineTwo.backgroundColor = [UIColor redColor];
    lineTwo.tag = 2001;
    [self.contentView addSubview:lineTwo];
    self.lineOne = lineTwo;
    
    
    
    // 选中按钮
    UIButton * selectButton = [UIButton buttonWithType:UIButtonTypeCustom];

    selectButton.frame = CGRectMake(5, 10, 50, 50);
    [selectButton setImage:[UIImage imageNamed:@"mark_UnSelectedBg"] forState:UIControlStateNormal];
    [selectButton setImage:[UIImage imageNamed:@"mark_SelectedBg"] forState:UIControlStateSelected];
    [self addSubview:selectButton];
    [selectButton addTarget:self action:@selector(selectallOfCell:) forControlEvents:UIControlEventTouchUpInside];
    self.selectButton = selectButton;
}


-(void)setselectButtonSeleted:(UIButton *)btn {
    if (btn.selected) {
        [btn setSelected:NO];
    }
    [btn setSelected:!btn.selected];
}


-(void)CancelsetselectButtonSeleted:(UIButton *)btn {
    if (!btn.selected) {
        [btn setSelected:YES];
    }
    [btn setSelected:!btn.selected];
}


-(void)selectallOfCell:(UIButton *)sender {
    if (self.selectButtonClick) {
       self.selectButtonClick(sender);
    }
}


-(void)setSelectButtonClick:(selectButtonBlock)selectButtonClick {
    _selectButtonClick = selectButtonClick;
}

/**
 *  cell
 */
-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self setLine:editing animated:animated];
    //[self setContentFrame:editing animated:animated];
    [self setSelectFrame:editing animated:animated];
}



-(void)setSelectFrame:(BOOL)editing animated:(BOOL)animated {
    CGRect selectRect = self.selectButton.frame;
    if (editing) {
        selectRect = CGRectMake(5, 10, 50, 50);
    }else {
        selectRect = CGRectMake(-100, 10, 50, 50);
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.selectButton.frame = selectRect;
    }];
}

/**
 *  设置细线
 */
-(void)setLine:(BOOL)editing animated:(BOOL)animated {
    CGPoint lineOneCenter = self.lineOne.center;
    if (editing) {
        lineOneCenter.x = -40;
    }else {
        lineOneCenter.x = 20;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.lineOne.center = lineOneCenter;
    }];
}

/**
 *  设置frame
 */
-(void)setContentFrame:(BOOL)editing animated:(BOOL)animated {
    CGPoint contentCenter = self.conView.center;
    if (editing) {
        contentCenter.x = contentCenter.x -10;
    }else {
        contentCenter.x = contentCenter.x + 10;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.conView.center = contentCenter;
    }];
}

@end
