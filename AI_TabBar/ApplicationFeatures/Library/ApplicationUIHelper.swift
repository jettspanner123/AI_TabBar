//
//  ApplicationUIHelper.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 01/10/25.
//

import Foundation
import SwiftUI

class ApplicationUIHelper {
    
    public static let current = ApplicationUIHelper()
    
    private init() { }
    public func togglePointerOnHover(hover: Bool) -> Void {
        if hover {
            NSCursor.pointingHand.set()
        } else {
            NSCursor.pointingHand.set()
        }
    }
}
