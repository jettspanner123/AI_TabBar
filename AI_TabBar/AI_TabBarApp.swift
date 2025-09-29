//
//  AI_TabBarApp.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 27/09/25.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct AI_TabBarApp: App {
    
    @NSApplicationDelegateAdaptor(ApplicationDelegate.self) var applicationDelegate
    
    
    var body: some Scene {
        Settings {}
    }
}

class ApplicationDelegate: NSObject, NSApplicationDelegate {
    var window: ClickableWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        
        let innerContent = ContentView()
        
        self.window = ClickableWindow(
            contentRect: NSRect(x: 300, y: 300, width: 1000, height: 60), styleMask: [.borderless], backing: .buffered, defer: false
        )
        
        self.window?.isReleasedWhenClosed = false
        self.window?.level = .floating
        self.window?.isOpaque = false
        self.window?.backgroundColor = .clear
        self.window?.isMovable = true
        
        self.window?.contentView = NSHostingView(rootView: innerContent)
        
        self.window?.makeKeyAndOrderFront(nil)
        self.window?.center()
    }
}

class ClickableWindow: NSWindow {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
}
