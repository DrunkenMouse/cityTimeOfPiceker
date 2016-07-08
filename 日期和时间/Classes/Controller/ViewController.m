//
//  ViewController.m
//  日期和时间
//
//  Created by 王奥东 on 16/3/12.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "ToolBar.h"
#import "provinces.h"
#import "ToolBar.h"
@interface ViewController ()<UITextFieldDelegate,ClickDataRource,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *city;

@property(assign,nonatomic)NSInteger selIndex;

@property(strong,nonatomic)ToolBar * toolbar;
@property(strong,nonatomic)NSArray *textFiles;
@property(strong,nonatomic)NSArray *provinces;
@property(assign,nonatomic)NSInteger lastPro;

@property(assign,nonatomic)NSInteger count;
@property(copy,nonatomic)NSString * str;
@end

@implementation ViewController

#pragma mark - 懒加载方式解析文件
-(NSArray *)provinces{
    if (_provinces==nil) {
        _provinces = [provinces provincesWithFile: [[NSBundle mainBundle]pathForResource:@"provinces.plist" ofType:nil]];
    }
    return _provinces;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    self.textFiles = @[self.birthday,self.city];
    self.birthday.delegate = self;
    self.city.delegate = self;
    
    //设置时间
    UIDatePicker *date = [[UIDatePicker alloc]init];
    date.datePickerMode = UIDatePickerModeDate;
    date.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    [date addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    //自己定义的类ToolBar
    ToolBar * toolbar = [ToolBar toolbar];
    toolbar.dataRource = self;
    self.toolbar = toolbar;
    //pickerView代理
    UIPickerView *city = [[UIPickerView alloc]init];
    city.dataSource = self;
    city.delegate = self;
    
    self.birthday.inputView = date;
    self.city.inputView =city;

    
    self.birthday.inputAccessoryView = toolbar;
    self.city.inputAccessoryView = toolbar;
    
}

#pragma mark - city的列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
#pragma mark - city的行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinces.count;
    }else{
        NSInteger pro = [pickerView selectedRowInComponent:0];
        NSArray *arr = [self.provinces[pro] cities];
        return arr.count;
    }
}
#pragma mark - 每行的内容
-(nullable NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
       
        return [self.provinces[row] name];
    }else{
        
        NSInteger pro = self.lastPro;
        NSArray *arr = [self.provinces[pro] cities];
        return arr[row];
    }
    
}
#pragma mark - 滚动结束后
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        //刷新指定列中的行
        [pickerView reloadComponent:1];
        //lastPro保存当前显示的是第一列的第几行
        self.lastPro = [pickerView selectedRowInComponent:0];
        //选择某一列的某一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
         _str = [self.provinces[row] name];
        
        //对空栏赋值
        NSArray *arr = [self.provinces[row] cities];
        self.city.text = [NSString stringWithFormat:@"%@-%@",_str,arr[0]];
        //消除BUG所用，不添加的话，则第一列不滚动时滚动第二列会显示为空
        self.count++;
    }else{
        //对空栏赋值
        NSArray *arr = [self.provinces[self.lastPro] cities];

        //设置内容的显示
       if (self.count == 0) {
            self.city.text = [NSString stringWithFormat:@"%@-%@",[self.provinces[0] name],arr[row]];
        }else{
            self.city.text = [NSString stringWithFormat:@"%@-%@",_str,arr[row]];
            }
        }
}

#pragma mark - 监听到的日期改变时
-(void)dateChange:(UIDatePicker *)picker{
    
    //获取当前选择的日期时间
    NSDate *date = picker.date;
    //设置时间显示的格式
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dates = [formatter stringFromDate:date];
    //对时间空栏赋值
    self.birthday.text = dates;
    
}

#pragma mark - 导航栏的点击事件
-(void)clickBtn:(ToolBar *)Bar  andBtnNum:(ToolBarBtn)btnNum{

    switch (btnNum) {
        case ToolBarOne:
            [self.textFiles[self.selIndex-1] becomeFirstResponder];
            break;
            
         case ToolBarTwo:
            [self.textFiles[self.selIndex+1] becomeFirstResponder];
            break;
            
        case ToolBarThree:
            [self.view endEditing:YES];
            break;
        default:
            break;
    }
}

#pragma mark - 导航栏是否能够点击的判断
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //是否能够点击的判断
    self.selIndex = [self.textFiles indexOfObject:textField];
    if (self.selIndex==0) {
        self.toolbar.preBtn.enabled = NO;
        self.toolbar.nextBtn.enabled = YES;
    }else if (self.selIndex == self.textFiles.count-1){
        self.toolbar.preBtn.enabled = YES;
        self.toolbar.nextBtn.enabled = NO;
    }else{
        self.toolbar.preBtn.enabled = YES;
        self.toolbar.nextBtn.enabled = YES;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
