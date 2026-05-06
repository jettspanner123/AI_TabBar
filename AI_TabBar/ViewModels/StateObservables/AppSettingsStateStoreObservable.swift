//
//  AppSettingsStateStoreObservable.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 05/05/26.
//

import Foundation
import SwiftUI

@Observable
class AppSettingsStateStoreObservable {
    
    private var appSettingsStateStore: AppSettingsStateStore?
    private var appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    
    init(appSettingsStateStore: AppSettingsStateStore?, appGlobalStateStoreObservable: AppGlobalStateStoreObservable?) {
        self.appSettingsStateStore = appSettingsStateStore
        self.appGlobalStateStoreObservable = appGlobalStateStoreObservable
    }
    
    func toggleShowSettingsView() -> Void {
        withAnimation {
            self.appSettingsStateStore?.isSettingsViewOpen.toggle()
        }
    }
    
    func setShowSettingsView(to: Bool) -> Void {
        self.appSettingsStateStore?.isSettingsViewOpen = to
    }
    
    
    func handleShowSettingsView() -> Void {
        if self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED {
            withAnimation {
                self.setShowSettingsView(to: true)
            }
            return
        }
        self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .EXPANDED)
        withAnimation {
            self.setShowSettingsView(to: true)
        }
    }
    
    func handleHideSettingsView() -> Void {
        if (self.appGlobalStateStoreObservable?.getIsAIAskResultNull()) == nil && ((self.appGlobalStateStoreObservable?.getIsAIDifferenceAskResultNull()) == nil) {
            withAnimation {
                self.setShowSettingsView(to: false)
            }
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .COLLAPSED)
            return
        }
        withAnimation {
            self.setShowSettingsView(to: false)
        }
    }
}
