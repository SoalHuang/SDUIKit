//
//  InputKeyboard.swift
//  SDUIKit
//
//  Created by SoalHunag on 2019/3/25.
//  Copyright © 2019 SoalHuang. All rights reserved.
//

import UIKit
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

public protocol InputKeyboardToolViewType: ViewableType {
    
    var titleLabel: UILabel { get }
    
    var leftButton: UIButton { get }
    
    var rightButton: UIButton { get }
}

final public class InputKeyboard<T: ViewableType>: UIView {
    
    public typealias contentType = T
    
    public var toolBar: InputKeyboardToolViewType = InputKeyboardToolView(frame: CGRect(width: UIScreen.main.bounds.width, height: 44)) {
        didSet {
            setNeedsLayout()
        }
    }
    
    public private(set) weak var content: T?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(frame: CGRect, content: T) {
        self.content = content
        super.init(frame: frame)
        
        toolBar.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        addSub(content)
        addSub(toolBar)
        
        toolBar.bringToFront()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        toolBar.view.sd.layout {
            $0.height = 44
            $0.top = 0
            $0.left = 0
            $0.right = bounds.width
        }
        
        if let `content` = content {
            content.view.sd.layout {
                $0.top = toolBar.frame.maxY
                $0.left = 0
                $0.bottom = bounds.height
                $0.right = bounds.width
            }
        }
    }
    
    private var dataSource: InputKeyboard<UIPickerView>.PickerDataSource?
}

final public class InputKeyboardToolView: UIView, InputKeyboardToolViewType {
    
    deinit {
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        backgroundColor = .white
        
        addSubview(leftButton)
        addSubview(titleLabel)
        addSubview(rightButton)
        addSubview(toolBarLine)
        
        toolBarLine.sd.layout {
            $0.height = 1
            $0.left = 0
            $0.bottom = bounds.height
            $0.right = bounds.width
        }
        
        leftButton.sd.layout {
            $0.width = 52
            $0.height = 28
            $0.left = DeviceIsXGroup ? 50 : 20
            $0.centerY = bounds.height * 0.5
        }
        
        rightButton.sd.layout {
            $0.width = 52
            $0.height = 28
            $0.right = bounds.width - (DeviceIsXGroup ? 50 : 20)
            $0.centerY = bounds.height * 0.5
        }
        
        titleLabel.sd.layout {
            $0.left = leftButton.sd.right + 4
            $0.right = rightButton.sd.left - 4
            $0.height = 28
            $0.centerY = bounds.height * 0.5
        }
    }
    
    lazy var toolBarLine: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor(hex: 0xe1e1e1)
        return temp
    }()
    
    public lazy var leftButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 52, height: 32))
        button.setTitleColor(UIColor(hex: 0x959595), for: .disabled)
        button.setTitleColor(UIColor(hex: 0x313131), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("取 消", for: .normal)
        return button
    }()
    
    public lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.backgroundColor = .clear
        temp.font = UIFont.systemFont(ofSize: 14)
        temp.textColor = UIColor(hex: 0x000000)
        temp.textAlignment = .center
        return temp
    }()
    
    public lazy var rightButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 52, height: 32))
        button.setTitleColor(UIColor(hex: 0x959595), for: .disabled)
        button.setTitleColor(UIColor(hex: 0x313131), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("确 定", for: .normal)
        return button
    }()
}
