//
//  MKTimeChoiceView.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 2017/9/22.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "MKTimeChoiceView.h"

@implementation MKTimeChoiceView
{
    UIPickerView *_pickerView;
    UIButton *confirmButn;
    
    NSMutableArray *dayArra;
    NSMutableArray *monthArra;
    NSMutableArray *yearArra;
    NSMutableArray *allDaysArra;
    
    NSMutableArray *limitYearArra;
    NSMutableArray *limitMonthArra;
    NSMutableArray *limitDayArra;
    
    NSDate *_date;
    NSString *year;
    NSString *month;
    NSString *day;
    
    NSString *limitYear;
    NSString *limitMonth;
    NSString *limitDay;
    NSInteger limitDayCount;
    
    BOOL _isFilter;
}

- (instancetype)initWithDate:(NSDate *)date isFilter:(BOOL)isFilter{
    
    _date = date;
    _isFilter = isFilter;
    _hasFiltered = NO;
    
    self = [super init];
    
    return self;
}

- (void)CreatView {
    
    confirmButn = [[UIButton alloc] init];
    _pickerView = [[UIPickerView alloc] init];
    
    [self addSubview:confirmButn];
    [self addSubview:_pickerView];
}

- (void)SettingViewAttributes {
    
    WS(ws)
    
    self.backgroundColor = customWhite;
    
    [self initAllDataArrays];
    
    [confirmButn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButn setTitleColor:[UIColor hexStringToColor:@"#476288"] forState:UIControlStateNormal];
    [confirmButn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    confirmButn.titleLabel.font = FONT(15);
    [confirmButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(60 * autoSizeScaleW, 40 * autoSizeScaleH));
    }];
    
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_pickerView selectRow:[yearArra indexOfObject:year] inComponent:0 animated:YES];
    [_pickerView selectRow:[monthArra indexOfObject:month] inComponent:1 animated:YES];
    [_pickerView selectRow:[allDaysArra indexOfObject:day] inComponent:2 animated:YES];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws).offset(leftPadding);
        make.right.mas_equalTo(ws).offset(rightPadding);
        make.top.mas_equalTo(confirmButn.mas_bottom);
        make.height.mas_equalTo(185 * autoSizeScaleH);
    }];
    
    [ws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_pickerView);
    }];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
        {
            if (_isFilter && _hasFiltered) {
                return limitYearArra.count;
            }
            return yearArra.count;
        }
            break;
            
        case 1:
        {
            if (_isFilter && _hasFiltered && [year isEqualToString:limitYear]) {
                return limitMonthArra.count;
            }
            return monthArra.count;
        }
            break;
            
        default:
        {
            [self checkFebruary:year];
            NSInteger index = [monthArra indexOfObject:month];
            //NSInteger count = [dayArra[index] integerValue];
            if (_isFilter && _hasFiltered && [year isEqualToString:limitYear] && [month isEqualToString:limitMonth]) {
                return limitDayCount;
            }
            return [dayArra[index] integerValue];
        }
            break;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

    return (SCREEN_WIDTH - 30 * autoSizeScaleW) / 3;

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {

    return 40 * autoSizeScaleH;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    UILabel *Content = [[UILabel alloc] init];
    Content.font = FONT(20);
    Content.textColor = wordThreeColor;
    Content.textAlignment = NSTextAlignmentCenter;
    NSString *contentStr;
    switch (component) {
        case 0:
            contentStr = [NSString stringWithFormat:@"%@年",yearArra[row]];
            if (_isFilter && _hasFiltered) {
                contentStr = [NSString stringWithFormat:@"%@年",limitYearArra[row]];
            }
            break;
        case 1:
            contentStr = [NSString stringWithFormat:@"%@月",monthArra[row]];
            if (_isFilter && _hasFiltered && [year isEqualToString:limitYear]) {
                contentStr = [NSString stringWithFormat:@"%@月",limitMonthArra[row]];
            }
            break;
        default:
            contentStr = [NSString stringWithFormat:@"%@日",allDaysArra[row]];
            if (_isFilter && _hasFiltered && [year isEqualToString:limitYear] && [month isEqualToString:limitMonth]) {
                contentStr = [NSString stringWithFormat:@"%@日",limitDayArra[row]];
            }
            break;
    }
    Content.text = contentStr;
    return Content;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    switch (component) {
        case 0:
            year = yearArra[row];
            if (_hasFiltered && _isFilter) {
                year = limitYearArra[row];
            }
            [self checkFebruary:year];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            break;
        case 1:
            month = monthArra[row];
            if (_isFilter && _hasFiltered && [year isEqualToString:limitYear]) {
                month = limitMonthArra[row];
            }
            [pickerView reloadComponent:2];
            break;
        default:
            day = allDaysArra[row];
            if (_isFilter && _hasFiltered && [year isEqualToString:limitYear] && [month isEqualToString:limitMonth]) {
                day = limitDayArra[row];
            }
            break;
    }
}

- (void)initAllDataArrays {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *cuurentDate = [formatter stringFromDate:_date];
    NSArray *array = [cuurentDate componentsSeparatedByString:@"-"];

    year = array[0];
    month = array[1];   //默认选中当前时间
    day = array[2];
    NSInteger yearNum = [year integerValue];
    NSString *february;
    if (yearNum % 4 == 0 && yearNum % 100 != 0) {     //判断是否为闰年  改变二月的天数
        february = @"29";
    }else if(yearNum % 400 == 0){
        february = @"29";
    }else{
        february = @"28";
    }
    dayArra = [[NSMutableArray alloc] initWithObjects:@"31",february,@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];

    yearArra = [[NSMutableArray alloc] init];
    monthArra = [[NSMutableArray alloc] init];
    allDaysArra = [[NSMutableArray alloc] init];
    
    limitYearArra = [[NSMutableArray alloc] init];
    limitMonthArra = [[NSMutableArray alloc] init];
    limitDayArra = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 32; i ++) {
        NSString *number = [NSString stringWithFormat:i < 10 ? @"0%d" : @"%d",i];
        [allDaysArra addObject:number];
        if (i < 13) {
            [monthArra addObject:number];
        }
    }
    for (int i = 1970; i < 2100; i ++) {
        NSString *number = [NSString stringWithFormat:@"%d",i];
        [yearArra addObject:number];
    }

}

- (void)initLimitArras {
    
    NSInteger yearIndex = [yearArra indexOfObject:limitYear];
    NSInteger monthIndex = [monthArra indexOfObject:limitMonth];
    NSInteger dayIndex = [allDaysArra indexOfObject:limitDay];
    
    [self checkFebruary:limitYear];
    if (!_searchType) {
        limitDayCount = dayIndex + 1;
    } else {
        NSInteger allDays = [dayArra[monthIndex] integerValue];
        limitDayCount = allDays - dayIndex;
    }
    
    [self filterArray:limitYearArra WithArra:yearArra AndIndex:yearIndex];
    [self filterArray:limitMonthArra WithArra:monthArra AndIndex:monthIndex];
    [self filterArray:limitDayArra WithArra:allDaysArra AndIndex:dayIndex];
    
}

- (void)filterArray:(NSMutableArray *)filteredArra WithArra:(NSMutableArray *)targetArra AndIndex:(NSInteger)index {
    
    [filteredArra removeAllObjects];
    for (int i = 0; i < targetArra.count; i ++) {
        if (!_searchType) {
            if (i <= index) {
                [filteredArra addObject:targetArra[i]];
                continue;
            }
            break;
        }else{
            if (i >= index) {
                [filteredArra addObject:targetArra[i]];
            }
        }
    }
    
}

- (void)setLimitString:(NSString *)dateString {
    
    NSArray *array = [dateString componentsSeparatedByString:@"-"];
    limitYear = array[0];
    limitMonth = array[1];
    limitDay = array[2];
    
    _hasFiltered = YES;
    
    [self initLimitArras];
    
    [_pickerView reloadAllComponents];
    
    [_pickerView selectRow:[limitYearArra indexOfObject:limitYear] inComponent:0 animated:YES];
    [_pickerView selectRow:[limitMonthArra indexOfObject:limitMonth] inComponent:1 animated:YES];
    [_pickerView selectRow:[limitDayArra indexOfObject:limitDay] inComponent:2 animated:YES];
}

- (void)checkFebruary:(NSString *)yearStr {
    
    NSInteger yearNum = [yearStr integerValue];
    NSString *february;
    if (yearNum % 4 == 0 && yearNum % 100 != 0) {     //判断是否为闰年  改变二月的天数
        february = @"29";
    }else if(yearNum % 400 == 0){
        february = @"29";
    }else{
        february = @"28";
    }
    [dayArra replaceObjectAtIndex:1 withObject:february];
    
}

- (void)confirmClick {
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:dateStr];
    if (_timeConfirmBlock) {
        _timeConfirmBlock(date);
    }
}


@end
