//
//  UIDevice+Extension.swift
//  RiveIslandOverlay
//
//  Created by Zach Plata on 9/25/22.
//

import Foundation
import SwiftUI

extension UIDevice {
    static var hasDynamicIsland: Bool {
        ["iPhone 14 Pro", "iPhone 14 Pro Max"].contains(current.name)
    }
}
