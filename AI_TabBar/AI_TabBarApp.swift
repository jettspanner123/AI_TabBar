import SwiftUI
import SwiftData
import FirebaseCore
import HotKey

@main
struct AI_TabBarApp: App {
    
    @NSApplicationDelegateAdaptor(ApplicationDelegate.self) var applicationDelegate
    
    let hotKey = HotKey(key: .space, modifiers: [.command, .shift])
    
    
    init() {
        let delegate = applicationDelegate
        hotKey.keyDownHandler = {
            delegate.toggleWindow()
        }
        
    }
    
    var body: some Scene {
        Settings {}
    }
}

class ApplicationDelegate: NSObject, NSApplicationDelegate {
    var window: ClickableWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        guard let mainScreen = NSScreen.main else { return }
        
        let innerContent = ContentView()
        
        
        self.window = ClickableWindow(
            contentRect: NSRect(x: (mainScreen.frame.width / 2) - 450, y: 1000, width: 900, height: 60), styleMask: [.borderless], backing: .buffered, defer: false
        )
        
        self.window?.isReleasedWhenClosed = false
        
        let highestPossibleLevel = CGWindowLevelForKey(.maximumWindow)
        self.window?.level = NSWindow.Level(rawValue: Int(highestPossibleLevel))
        self.window?.isOpaque = false
        self.window?.backgroundColor = .clear
        self.window?.isMovable = true
        
        self.window?.contentView = NSHostingView(rootView: innerContent)
        
        self.window?.makeKeyAndOrderFront(nil)
    }
    
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        return .terminateCancel
    }
    
    func toggleWindow() {
        guard let window = self.window else { return }
        
        if window.isVisible {
            // Hides the window without quitting the app
            window.orderOut(nil)
            NSApp.deactivate()
        } else {
            // Shows the window and makes it active
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true) // Ensure the app is frontmost
            window.makeKey()
        }
    }
    
    func hideWindow() {
        guard let window = self.window else { return }
        
        if window.isVisible {
            window.orderOut(nil)
            NSApp.deactivate()
        }
    }
}

class ClickableWindow: NSWindow {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}
