# KIMaskView
使用Swift封装遮罩视图为组件，封装datePicker，封装PickerView，使用简单。

使用举例

```
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

```

```
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
```