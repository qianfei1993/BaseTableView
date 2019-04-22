//
//  BaseTableViewCell.m
//  BaseTableView
//
//  Created by damai on 2019/4/17.
//  Copyright © 2019 personal. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initWithConfig];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initWithConfig];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initWithConfig];
    }
    return self;
}

- (void)layoutIfNeeded{
    self.separatorLine.frame = CGRectMake(0, self.contentView.frame.size.height-1, self.contentView.frame.size.width, 1);
}

- (void)initWithConfig{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.separatorLine];
}

- (UIView*)separatorLine{

    if (!_separatorLine) {
        _separatorLine = [[UIView alloc]init];
        _separatorLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _separatorLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
