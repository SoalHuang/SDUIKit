//
//  SDColorButton.swift
//  SDUIKit
//
//  Created by soso on 2017/5/12.
//
//

import UIKit

@IBDesignable
public class SDColorButton: UIButton {
    
    override public var isEnabled: Bool {
        didSet {
            updateBackgroundStateColor()
            updateBorderStateColor()
        }
    }
    
    override public var isHighlighted: Bool {
        didSet {
            updateBackgroundStateColor()
            updateBorderStateColor()
        }
    }
    
    override public var isSelected: Bool {
        didSet {
            updateBackgroundStateColor()
            updateBorderStateColor()
        }
    }
    
    public private(set) var catchStates: [UIControl.State] = [.normal, .highlighted, .disabled, .selected]
    public private(set) var backgroundStateColors: [UIControl.State.RawValue: UIColor] = [:]
    public private(set) var borderStateColors: [UIControl.State.RawValue: UIColor] = [:]
}

public extension SDColorButton {
    
    func backgroundColor(for state: UIControl.State) -> UIColor? {
        return backgroundStateColors[state.rawValue]
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        guard catchStates.contains(state) else { return }
        backgroundStateColors[state.rawValue] = color
        updateBackgroundStateColor()
    }
    
    func setBackgroundColor(_ color: UIColor?, for states: [UIControl.State]) {
        states.filter { catchStates.contains($0) }.forEach { backgroundStateColors[$0.rawValue] = color }
        updateBackgroundStateColor()
    }
    
    private func updateBackgroundStateColor() {
        guard isEnabled else {
            if let bgColor = backgroundStateColors[UIControl.State.disabled.rawValue] {
                backgroundColor = bgColor
            }
            return
        }
        if isHighlighted {
            if let bgColor = backgroundStateColors[UIControl.State.highlighted.rawValue] {
                backgroundColor = bgColor
            }
            return
        }
        if isSelected {
            if let bgColor = backgroundStateColors[UIControl.State.selected.rawValue] {
                backgroundColor = bgColor
            }
            return
        }
        if let bgColor = backgroundStateColors[UIControl.State.normal.rawValue] {
            backgroundColor = bgColor
        }
    }
}

public extension SDColorButton {
    
    func borderColor(for state: UIControl.State) -> UIColor? {
        return borderStateColors[state.rawValue]
    }
    
    func setBorderColor(_ color: UIColor?, for state: UIControl.State) {
        guard catchStates.contains(state) else { return }
        borderStateColors[state.rawValue] = color
        updateBorderStateColor()
    }
    
    func setBorderColor(_ color: UIColor?, for states: [UIControl.State]) {
        states.filter { catchStates.contains($0) }.forEach { borderStateColors[$0.rawValue] = color }
        updateBorderStateColor()
    }
    
    private func updateBorderStateColor() {
        guard isEnabled else {
            layer.borderColor = (borderStateColors[UIControl.State.disabled.rawValue] ?? .clear).cgColor
            return
        }
        if isHighlighted {
            layer.borderColor = (borderStateColors[UIControl.State.highlighted.rawValue] ?? .clear).cgColor
            return
        }
        if isSelected {
            layer.borderColor = (borderStateColors[UIControl.State.selected.rawValue] ?? .clear).cgColor
            return
        }
        layer.borderColor = (borderStateColors[UIControl.State.normal.rawValue] ?? .clear).cgColor
    }
}
