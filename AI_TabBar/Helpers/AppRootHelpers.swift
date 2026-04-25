import Foundation
import SwiftUI


class AppRootHelpers {
    public static let current = AppRootHelpers()
    
    
    func hideWindow(_ window: NSWindow) {
        if window.isVisible {
            window.orderOut(nil)
            NSApp.deactivate()
        }
    }
    
    func makeWindowInvisibleToCapture(_ window: NSWindow) {
        let conn = CGSMainConnectionID()
        var tags: UInt32 = 0x20
        CGSSetWindowTags(conn, Int32(window.windowNumber), &tags, 32)
        
        window.sharingType = .none
    }
    
    func toggleWindow(_ window: NSWindow) {
        if window.isVisible {
            window.orderOut(nil)
            NSApp.deactivate()
        } else {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            window.makeKey()
            self.makeWindowInvisibleToCapture(window)
        }
    }
    
    func centerWindowHorizontally(_ window: NSWindow?) {
        guard let window, let screen = NSScreen.main else { return }
        
        let x = (screen.frame.width - window.frame.width) / 2
        let y = window.frame.origin.y
        
        window.setFrameOrigin(NSPoint(x: x, y: y))
    }
}
