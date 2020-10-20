//
//  InputKeyboard.swift
//  SDUIKit
//
//  Created by SoalHunag on 2019/3/25.
//  Copyright © 2019 SoalHuang. All rights reserved.
//

import UIKit
import SnapKit
import SDFoundation

extension InputKeyboard where T: UIDatePicker {
    
}

extension InputKeyboard where T: UIPickerView {
    
    public var items: [String]? {
        get { return dataSource?.items }
        set {
            dataSource = InputKeyboard<UIPickerView>.PickerDataSource(items: newValue ?? [])
            content?.dataSource = dataSource
            content?.delegate = dataSource
            content?.reloadComponent(0)
        }
    }
    
    public var item: String? {
        guard let row = content?.selectedRow(inComponent: 0) else { return nil }
        return dataSource?.items[safe: row]
    }
    
    public var changed: ((String?) -> Void)? {
        get { return dataSource?.action }
        set { dataSource?.action = newValue }
    }
    
    private class PickerDataSource: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        
        fileprivate var items: [String] = []
        fileprivate var action: ((String?) -> Void)?
        
        init(items: [String]) {
            super.init()
            self.items = items
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return items.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return items[safe: row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            action?(items[safe: row])
        }
    }
}

final public class InputKeyboard<T: ViewableType>: UIView {
    
    public typealias contentType = T
    
    public private(set) weak var content: T?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(frame: CGRect, content: T) {
        self.content = content
        super.init(frame: frame)
        addSubview(toolBar)
        toolBar.addSubview(leftButton)
        toolBar.addSubview(rightButton)
        
        let toolBarLine = UIView()
        toolBarLine.backgroundColor = UIColor(hex: 0xe1e1e1)
        toolBar.addSubview(toolBarLine)
        
        toolBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        toolBarLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.bottom.right.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(DeviceIsXGroup ? 50 : 20)
            $0.width.equalTo(52)
            $0.height.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        rightButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(DeviceIsXGroup ? -50 : -20)
            $0.width.equalTo(52)
            $0.height.equalTo(28)
            $0.centerY.equalToSuperview()
        }
        
        insertSubview(content, at: 0)
        content.snp.makeConstraints {
            $0.top.equalTo(toolBar.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }
    }
    
    public lazy var toolBar: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return v
    }()
    
    public lazy var leftButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 52, height: 32))
        button.setTitleColor(UIColor(hex: 0x959595), for: .disabled)
        button.setTitleColor(UIColor(hex: 0x313131), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("取 消", for: .normal)
        return button
    }()
    
    public lazy var rightButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 52, height: 32))
        button.setTitleColor(UIColor(hex: 0x959595), for: .disabled)
        button.setTitleColor(UIColor(hex: 0x313131), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("确 定", for: .normal)
        return button
    }()
    
    private var dataSource: InputKeyboard<UIPickerView>.PickerDataSource?
}
