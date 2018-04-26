//
//  KIPickerView.swift
//  KIMaskViewDemo
//
//  Created by xinyu on 2018/4/26.
//  Copyright © 2018年 MaChat. All rights reserved.
//

import UIKit

class KIPickerView: KIBasePickerView {

    var dataSource = [Any]()
    weak var delegate: KIPickerViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let picker = UIPickerView.init(frame:CGRect(x: 0, y: heightForToolbar, width: UIScreen.main.bounds.width, height: heightForPickerView))
        picker.delegate = self
        picker.dataSource = self
        pickerView = picker
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func cancel() {
        super.cancel()
        dismiss()
    }
    
    override func confirm() {
        super.confirm()
        dismiss()
        let picker = pickerView as! UIPickerView
        let row = picker.selectedRow(inComponent: 0)
        var item:(Any)? = nil
        if dataSource.count > 0 && row < dataSource.count{
            item = dataSource[row]
        }
        delegate?.pickerViewDidConfirm(pickerView: picker, didSelectRow: row,item:item )
    }
    
    func selectRow(_ row: Int,inComponent component: Int, animated: Bool) {
        var index = row
        let picker = pickerView as! UIPickerView
        let maxRow = pickerView(picker, numberOfRowsInComponent: component)
        if index > maxRow {
            index = maxRow - 1
        }
        picker.selectRow(index, inComponent: component, animated: animated)
    }
}

protocol KIPickerViewDelegate: class {
    func pickerViewDidConfirm(pickerView:UIPickerView,didSelectRow row:Int, item:Any?) ->Void
}

extension KIPickerView: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.dataSource.count > 0 {
            let item  = dataSource[row]
            let title = String(format: "%@", item as! CVarArg)
            return title
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var tLabel: UILabel
        if view == nil || !(view?.isKind(of: UILabel.self))! {
            let rowSize = pickerView.rowSize(forComponent: component)
            let x = (pickerView.frame.width - rowSize.width)/2
            let label = UILabel.init(frame: CGRect(x: x, y: 0, width: rowSize.width, height: rowSize.height))
            label.backgroundColor = UIColor.clear
            label.font = UIFont.systemFont(ofSize: 22.0)
            label.textColor = UIColor.darkText
            label.textAlignment = NSTextAlignment.center
            tLabel = label
        } else {
            tLabel = view as! UILabel
        }
        let title = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        tLabel.text = title
        return tLabel
    }
}
