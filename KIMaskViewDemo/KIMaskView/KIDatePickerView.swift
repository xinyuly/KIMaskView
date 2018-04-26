//
//  KIDatePickerView.swift
//  KIMaskViewDemo
//
//  Created by xinyu on 2018/4/24.
//  Copyright © 2018年 MaChat. All rights reserved.
//

import UIKit

class KIBasePickerView: KIMaskView {
    var titleLabel: UILabel?
    
    lazy var toolbar: UIToolbar? = {
        let toolbar = UIToolbar.init()
        toolbar.barStyle = .default
        toolbar.frame = CGRect(x: 0, y: 0, width: (windowFrame?.width)!, height: heightForToolbar)
        let paddingLeft = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        paddingLeft.width = 15.0
        let paddingRight = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        paddingRight.width = 15.0
        //取消按钮
        let cancelButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(cancel))
        
        let flexibleSpaceButtonItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //确定按钮
         let confirmButtonItem = UIBarButtonItem.init(title: "确定", style: .plain, target: self, action: #selector(confirm))
        
        var items = [UIBarButtonItem]()
        items.append(paddingLeft)
        items.append(cancelButtonItem)
        items.append(flexibleSpaceButtonItem)
        items.append(confirmButtonItem)
        items.append(paddingRight)
        toolbar.items = items
        return toolbar
    }()
    
    var pickerView: UIView?
    
    var heightForPickerView: CGFloat = 216.0
    let heightForToolbar: CGFloat = 44.0
    var heightForContentView: CGFloat {
        get{
            return CGFloat(heightForToolbar + heightForPickerView)
        }
    }
    
    fileprivate var windowFrame: CGRect? {
        get{
            return UIApplication.shared.keyWindow?.frame
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        heightForPickerView = frame.height - heightForToolbar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancel() {
    
    }
    
    @objc func confirm() {
        
    }
    
    func show() {
        contentView = UIView.init(frame: CGRect(x: 0, y: 0, width: (windowFrame?.width)!, height: heightForContentView))
        contentView?.backgroundColor = UIColor.white
        contentView?.addSubview(toolbar!)
        contentView?.addSubview(pickerView!)
        dockToSide = .bottom
        showInView(view: UIApplication.shared.keyWindow!)
    }
}

class KIDatePickerView: KIBasePickerView {
    
    weak var delegate: UIDatePickerDelegate?
    
    var datePickerMode:UIDatePickerMode? {
        didSet{
            datePicker.datePickerMode = datePickerMode!
        }
    }
   
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: heightForToolbar, width: UIScreen.main.bounds.width, height: heightForPickerView))
        datePicker.addTarget(self, action: #selector(datePicketDidChangeValue(datePicker:)), for: .valueChanged)
        return datePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pickerView = datePicker
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func datePicketDidChangeValue(datePicker:UIDatePicker) {
        
    }
    
    override func cancel() {
        super.cancel()
        dismiss()
    }
    
    override func confirm() {
        super.confirm()
        dismiss()
        delegate?.datePickeDidConfirm(datePicker: datePicker, date: datePicker.date)
    }
    
}

protocol UIDatePickerDelegate: class {
    func datePickeDidConfirm(datePicker:UIDatePicker,date:Date) -> Void
//    @objc optional func datePickerDidChangeValue(datePicker:UIDatePicker) -> Void
}
