# HZTableView_selectAll_single
OC的tableview的选中、全选、取消全选demo，（纯代码手动打造）


## 项目结构
<img style="-webkit-user-select: none;" src="https://mmbiz.qlogo.cn/mmbiz/wFa30ADx7kIafSnwNlQX57ra5HJib7otxrONEyWn47zwPGDiciarQhf0R2lgJM92j8K4ycfXydgibS0uVpyNK8mysA/0?wx_fmt=jpeg" width="30%" height="40%">
## 系统界面
<img style="-webkit-user-select: none;" src="https://mmbiz.qlogo.cn/mmbiz/wFa30ADx7kIafSnwNlQX57ra5HJib7otxWvKhaD1cicTNibuRHeMJHB1tcOHVOaGToxLdfiaTYAEW2JicWkuibCEwfgw/0?wx_fmt=png" width="30%" height="40%"> 
## 编辑界面
<img style="-webkit-user-select: none;" src="https://mmbiz.qlogo.cn/mmbiz/wFa30ADx7kIafSnwNlQX57ra5HJib7otxdTmxDfzYK5nT4esghvItSN0qpvdryhDZMlAdQljHnfvPxDODITiczSQ/0?wx_fmt=png" width="30%" height="40%"> 

```ruby
 全选功能和取消全选功能可以看一下demo
 ```
 
 
## 单选功能实现（Block）
```ruby
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
```
##全选按钮
```ruby
// 遍历所有的section下面的cell获取未显示的cell置为选中状态
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

-(void)setselectButtonSeleted:(UIButton *)btn {
    if (btn.selected) {
        [btn setSelected:NO];
    }
    [btn setSelected:!btn.selected];
}
```



##取消全选
```ruby
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



-(void)CancelsetselectButtonSeleted:(UIButton *)btn {
    if (!btn.selected) {
        [btn setSelected:YES];
    }
    [btn setSelected:!btn.selected];
}
```


```ruby
请添加洲洲哥的公众号，不定期有干货推送哦
```
