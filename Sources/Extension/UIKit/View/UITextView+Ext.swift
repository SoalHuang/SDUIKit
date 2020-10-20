//
//  UITextView+Ext.swift
//  SDUIKit
//
//  Created by SoalHunag on 2018/4/26.
//  Copyright © 2018年 SoalHuang. All rights reserved.
//

import UIKit
import SDFoundation

public extension SDExtension where T: UITextView {
    
    @discardableResult
    func on(_ type: SDTextViewActionTypes) -> SDExtension {
        guard let targets = base.kit_textViewTarget else {
            base.kit_textViewTarget = TextViewDelegateTarget(base)
            base.kit_textViewTarget?.on(type)
            return self
        }
        targets.on(type)
        return self
    }
    
    @discardableResult
    func off(_ type: SDTextViewActionTypes) -> SDExtension {
        base.kit_textViewTarget?.off(type)
        guard let types = base.kit_textViewTarget?.types, types.count > 0 else {
            base.kit_textViewTarget = nil
            return self
        }
        return self
    }
}

public enum SDTextViewActionTypes {
    
    case shouldBeginEditing((UITextView) -> Bool)
    case shouldEndEditing((UITextView) -> Bool)
    case beginEditing((UITextView) -> Void)
    case endEditing((UITextView) -> Void)
    case shouldReplacement((UITextView, NSRange, String) -> Bool)
    case didChange((UITextView) -> Void)
    case didChangeSelection((UITextView) -> Void)
    case shouldClear((UITextView) -> Bool)
    case shouldReturn((UITextView) -> Bool)
    
    @available(iOS 10.0, *)
    case shouldURLInteraction((UITextView, URL, NSRange, UITextItemInteraction) -> Bool)
    
    @available(iOS 10.0, *)
    case shouldAttachmentInteraction((UITextView, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)
    
}

extension SDTextViewActionTypes: RawRepresentable {
    
    public typealias RawValue = Int
    
    public init?(rawValue: Int) {
        switch rawValue {
        case 0: self = SDTextViewActionTypes.shouldBeginEditing({ _ -> Bool in return true })
        case 1: self = SDTextViewActionTypes.shouldEndEditing({ _ -> Bool in return true })
        case 2: self = SDTextViewActionTypes.beginEditing({ _ in })
        case 3: self = SDTextViewActionTypes.endEditing({ _ in })
        case 4: self = SDTextViewActionTypes.shouldReplacement({ (_, _, _) -> Bool in return true })
        case 5: self = SDTextViewActionTypes.didChange({ _ in })
        case 6: self = SDTextViewActionTypes.didChangeSelection({ _ in })
        case 7: self = SDTextViewActionTypes.shouldClear({ _ in return true })
        case 8: self = SDTextViewActionTypes.shouldReturn({ _ in return true })
        case 9:
            if #available(iOS 10.0, *) {
                self = SDTextViewActionTypes.shouldURLInteraction({ (_, _, _, _) -> Bool in return true })
            } else {
                self = SDTextViewActionTypes.shouldBeginEditing({ _ -> Bool in return true })
            }
        case 10:
            if #available(iOS 10.0, *) {
                self = SDTextViewActionTypes.shouldAttachmentInteraction({ (_, _, _, _) -> Bool in return true })
            } else {
                self = SDTextViewActionTypes.shouldBeginEditing({ _ -> Bool in return true })
            }
        default: self = SDTextViewActionTypes.shouldBeginEditing({ _ -> Bool in return true })
        }
    }
    
    public var rawValue: Int {
        switch self {
        case .shouldBeginEditing(_):            return 0
        case .shouldEndEditing(_):              return 1
        case .beginEditing(_):                  return 2
        case .endEditing(_):                    return 3
        case .shouldReplacement(_):             return 4
        case .didChange(_):                     return 5
        case .didChangeSelection(_):            return 6
        case .shouldClear(_):                   return 7
        case .shouldReturn(_):                  return 8
        case .shouldURLInteraction(_):          return 9
        case .shouldAttachmentInteraction(_):   return 10
        }
    }
}

private var UITextView_Key_Target: String = "textView.sd.target.key"
fileprivate extension UITextView {
    
    var kit_textViewTarget: TextViewDelegateTarget? {
        get { return sd.binded(for: &UITextView_Key_Target) }
        set { sd.bind(object: newValue, for: &UITextView_Key_Target, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

fileprivate class TextViewDelegateTarget: NSObject, UITextViewDelegate {
    
    fileprivate weak var textView: UITextView?
    fileprivate var types: [Int: SDTextViewActionTypes] = [:]
    
    fileprivate init(_ textView: UITextView?) {
        super.init()
        self.textView = textView
        self.textView?.delegate = self
    }
    
    fileprivate func on(_ type: SDTextViewActionTypes) {
        types[type.rawValue] = type
    }
    
    fileprivate func off(_ type: SDTextViewActionTypes) {
        types.removeValue(forKey: type.rawValue)
    }
    
    fileprivate func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let type = SDTextViewActionTypes.shouldBeginEditing { (_) -> Bool in return true }
        guard case .shouldBeginEditing(let closure)? = types[type.rawValue] else { return true }
        return closure(textView)
    }
    
    fileprivate func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        let type = SDTextViewActionTypes.shouldEndEditing { (_) -> Bool in return true }
        guard case .shouldEndEditing(let closure)? = types[type.rawValue] else { return true }
        return closure(textView)
    }
    
    fileprivate func textViewDidBeginEditing(_ textView: UITextView) {
        let type = SDTextViewActionTypes.beginEditing { (_) in }
        guard case .beginEditing(let closure)? = types[type.rawValue] else { return }
        closure(textView)
    }
    
    fileprivate func textViewDidEndEditing(_ textView: UITextView) {
        let type = SDTextViewActionTypes.endEditing { (_) in }
        guard case .endEditing(let closure)? = types[type.rawValue] else { return }
        closure(textView)
    }
    
    fileprivate func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let shouldClear = SDTextViewActionTypes.shouldClear { _ in return true }
        if range.length == 1, text.count == 0, case .shouldClear(let closure)? = types[shouldClear.rawValue] {
            return closure(textView)
        }
        let shouldReturn = SDTextViewActionTypes.shouldReturn { _ in return true }
        if range.length == 0, text == "\n", case .shouldReturn(let closure)? = types[shouldReturn.rawValue] {
            return closure(textView)
        }
        let shouldReplacement = SDTextViewActionTypes.shouldReplacement { (_, _, _) -> Bool in return true }
        if case .shouldReplacement(let closure)? = types[shouldReplacement.rawValue] {
            return closure(textView, range, text)
        }
        return true
    }
    
    fileprivate func textViewDidChange(_ textView: UITextView) {
        let type = SDTextViewActionTypes.didChange { (_) in }
        guard case .didChange(let closure)? = types[type.rawValue] else { return }
        closure(textView)
    }
    
    fileprivate func textViewDidChangeSelection(_ textView: UITextView) {
        let type = SDTextViewActionTypes.didChangeSelection { (_) in }
        guard case .didChangeSelection(let closure)? = types[type.rawValue] else { return }
        closure(textView)
    }
    
    @available(iOS 10.0, *)
    fileprivate func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let type = SDTextViewActionTypes.shouldURLInteraction { (_, _, _, _) -> Bool in return true }
        guard case .shouldURLInteraction(let closure)? = types[type.rawValue] else { return true }
        return closure(textView, URL, characterRange, interaction)
    }
    
    @available(iOS 10.0, *)
    fileprivate func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let type = SDTextViewActionTypes.shouldAttachmentInteraction { (_, _, _, _) -> Bool in return true }
        guard case .shouldAttachmentInteraction(let closure)? = types[type.rawValue] else { return true }
        return closure(textView, textAttachment, characterRange, interaction)
    }
}
