//
//  ViewController.swift
//  KIMaskViewDemo
//
//  Created by xinyu on 2018/4/26.
//  Copyright © 2018年 MaChat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func testMaskView(_ sender: Any) {
        testMaskView()
    }
    
    @IBAction func testDatePicker(_ sender: Any) {
        testDatePicker()
    }
    
    @IBAction func testPickerView(_ sender: Any) {
        testPickerView()
    }
    
    //测试pickerView
    func testPickerView() {
        let pickerView = KIPickerView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        pickerView.dataSource = ["单选","多选","西红柿炒鸡蛋","青椒肉丝","茄子豆角","hahah","西红柿炒鸡蛋","青椒肉丝","茄子豆角","西红柿炒鸡蛋","青椒肉丝","茄子豆角","西红柿炒鸡蛋","青椒肉丝","茄子豆角"]
        pickerView.delegate = self
        pickerView.selectRow(1, inComponent: 0, animated: true)
        pickerView.show()
    }
    //测试datePicker
    func testDatePicker() {
        let pickerView = KIDatePickerView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        pickerView.datePicker.locale = Locale.init(identifier: "zh_Hans_CN")
        pickerView.datePicker.calendar = Calendar.current
        pickerView.datePicker.date = Date.init()
        pickerView.datePickerMode = .date
        pickerView.maskColor = UIColor.black.withAlphaComponent(0.1)
        pickerView.delegate = self
        pickerView.show()
    }
    //测试遮罩视图
    func testMaskView() {
        let window = UIApplication.shared.keyWindow
        let maskView = KIMaskView()
        maskView.dismissWhenTouchMaskView = true
        maskView.maskColor = UIColor.red.withAlphaComponent(0.1)
        let box = UIView()
        box.backgroundColor = UIColor.red
        box.frame = CGRect(x: 0, y: 0, width: 280, height: 330)
        maskView.dockToSide = .center
        
        maskView.contentView = box
        maskView.showInView(view: window!)
    }
    
}

extension ViewController: KIPickerViewDelegate {
    func pickerViewDidConfirm(pickerView: UIPickerView, didSelectRow row: Int, item: Any?) {
        print("\(row)"+"-----"+"\(String(describing: item))")
    }
}

extension ViewController: UIDatePickerDelegate {
    func datePickeDidConfirm(datePicker: UIDatePicker, date: Date) {
        print("test:"+"\(datePicker.date.timeIntervalSince1970)")
    }
    
    func datePickerDidChangeValue(datePicker: UIDatePicker) {
        print(datePicker.date.timeIntervalSince1970)
    }
    
}

