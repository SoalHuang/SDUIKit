//
//  MonitorWindow.swift
//  SDUIKit
//
//  Created by SoalHunag on 2020/5/6.
//  Copyright © 2020 SoalHuang. All rights reserved.
//

import UIKit

public class MonitorWindow: UIWindow {
    
    public var eventHandle: ((_ event: UIEvent) -> Void)?
    
    public override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        eventHandle?(event)
    }
}
