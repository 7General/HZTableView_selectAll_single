//
//  SelectCell.h
//  editTable
//
//  Created by 王会洲 on 16/4/1.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectButtonBlock)(id  btn);


@interface SelectCell : UITableViewCell

@property (nonatomic, copy) selectButtonBlock  selectButtonClick;

@property (nonatomic, strong) UIButton * selectButton;

+(instancetype)cellWithTableView:(UITableView *)table;
/**
 * 标题
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 *  checkBox
 */
@property (nonatomic, strong) UIButton * checkBox;


/**
 *  全选
 */
-(void)setselectButtonSeleted:(UIButton *)btn;

/**
 *  取消全选
 *
 *  @param btn <#btn description#>
 */
-(void)CancelsetselectButtonSeleted:(UIButton *)btn;

@end
