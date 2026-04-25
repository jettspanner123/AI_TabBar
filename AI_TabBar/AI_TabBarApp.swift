import SwiftUI
import SwiftData
import FirebaseCore
import HotKey

@main
struct AI_TabBarApp: App {
    
    @NSApplicationDelegateAdaptor(ApplicationDelegate.self) var applicationDelegate
    @State private var appGlobalStateStore = AppGlobalStateStore()
    
    let hotKey = HotKey(key: .space, modifiers: [.command, .shift])
    
    init() {
        let AppDelegate = applicationDelegate
        hotKey.keyDownHandler = {
            AppDelegate.toggleWindow()
        }
    }
    
    var body: some Scene {
        Settings {}
            .environment(self.appGlobalStateStore)
    }
}



class ClickableWindow: NSWindow {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
    override var acceptsFirstResponder: Bool { false }
}
