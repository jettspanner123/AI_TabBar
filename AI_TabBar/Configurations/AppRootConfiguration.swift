import Foundation
import SwiftUI

@_silgen_name("CGSMainConnectionID")
func CGSMainConnectionID() -> Int

@_silgen_name("CGSSetWindowTags")
func CGSSetWindowTags(_ cid: Int, _ wid: Int32, _ tags: inout UInt32, _ tagSize: Int32)

class ApplicationDelegate: NSObject, NSApplicationDelegate {
    var window: ClickableWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        guard let mainScreen = NSScreen.main else { return }
        
        let appGlobalStateStore = AppGlobalStateStore()
        let appGlobalStateStoreObservable = AppGlobalStateStoreObservable(appGlobalStateStore: appGlobalStateStore)
        
        let innerContent = ContentView().environment(appGlobalStateStore)
        let frame = NSRect(x: 0, y: mainScreen.frame.height - AppRootConstants.current.SEARCH_AREA_TOP_OFFSET, width: AppRootConstants.current.WINDOW_DIMENTIONS_COLLAPSED.width, height: appGlobalStateStoreObservable.getDynamicExpandedWindowHeight())
        
        let highestPossibleLevel = CGWindowLevelForKey(.maximumWindow)
        
        self.window = ClickableWindow(
            contentRect: frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        self.window?.isReleasedWhenClosed = false
        self.window?.level = NSWindow.Level(rawValue: Int(highestPossibleLevel))
        self.window?.isOpaque = false
        self.window?.backgroundColor = .clear
        self.window?.isMovable = true
        self.window?.collectionBehavior = [.canJoinAllSpaces, .stationary, .fullScreenAuxiliary]
        self.window?.contentView = NSHostingView(rootView: innerContent)
        self.window?.makeKeyAndOrderFront(nil)
        
        NSApp.setActivationPolicy(.accessory)
        AppRootHelpers.current.centerWindowHorizontally(self.window)
        AppRootHelpers.current.makeWindowInvisibleToCapture(self.window!)
    }
    
    
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        return .terminateCancel
    }
    
    func toggleWindow() {
        guard let window = self.window else { return }
        
        if window.isVisible {
            window.orderOut(nil)
            NSApp.deactivate()
        } else {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            window.makeKey()
            AppRootHelpers.current.makeWindowInvisibleToCapture(window)
        }
    }
}
