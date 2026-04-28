import Foundation
import SwiftUI


@Observable
class AppGlobalStateStoreObservable {
    private var appGlobalStateStore: AppGlobalStateStore
    
    init(appGlobalStateStore: AppGlobalStateStore) {
        self.appGlobalStateStore = appGlobalStateStore
    }
    
    func getSearchAreaExpantionState() -> AppSearchAreaExpantionState {
        return self.appGlobalStateStore.searchAreaExpantionState
    }
    
    func getDynamicExpandedWindowHeight() -> CGFloat {
        return self.appGlobalStateStore.searchAreaExpantionState == .EXPANDED ? AppRootConstants.current.WINDOW_DIMENTIONS_EXPANDED.height : AppRootConstants.current.WINDOW_DIMENTIONS_COLLAPSED.height
    }
    
    func setDynamicExpandedWindowHeight(to: AppSearchAreaExpantionState) {
        withAnimation {
            self.appGlobalStateStore.searchAreaExpantionState = to
        }
    }
    
    func toggleDynamicExpandedWindowSize() -> Void {
        withAnimation {
            self.appGlobalStateStore.searchAreaExpantionState = self.appGlobalStateStore.searchAreaExpantionState == .EXPANDED ? .COLLAPSED : .EXPANDED
        }
    }
    
    func getDynamicExpandedWindowWidth() -> CGFloat {
        return self.appGlobalStateStore.searchAreaExpantionState == .EXPANDED ? AppRootConstants.current.WINDOW_DIMENTIONS_EXPANDED.width : AppRootConstants.current.WINDOW_DIMENTIONS_COLLAPSED.width
    }
    
    func setDynamicExpandedWindowWidth(to: AppSearchAreaExpantionState) {
        withAnimation {
            self.appGlobalStateStore.searchAreaExpantionState = to
        }
    }
    
    func setSearchEntryState(to: AppSearchEntryState) {
        withAnimation {
            self.appGlobalStateStore.searchEntryState = to
        }
    }
    
    func getSearchEntryState() -> AppSearchEntryState {
        return self.appGlobalStateStore.searchEntryState
    }
    
    func searchEntryEquals(to: AppSearchEntryState) -> Bool {
        return self.appGlobalStateStore.searchEntryState == to
    }
}
