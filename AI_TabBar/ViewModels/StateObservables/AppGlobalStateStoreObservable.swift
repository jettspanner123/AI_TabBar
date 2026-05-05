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
    
    func getIsAIAskResultNull() -> Bool  {
        return self.appGlobalStateStore.askAISearchResponse == nil
    }
    
    func getIsAIDifferenceAskResultNull() -> Bool {
        return self.appGlobalStateStore.askAISearchDifferenceResponse == nil
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
    
    func setAskAISearchResult(to: APIResponse<AskAIQuestionResponse>?) {
        withAnimation {
            self.appGlobalStateStore.askAISearchResponse = to
        }
    }
    
    func setNetworkCallType(to: NetworkCallType) -> Void {
        if to == self.appGlobalStateStore.currentSelectedNetworkCallType { return }
        withAnimation {
            self.appGlobalStateStore.currentSelectedNetworkCallType = to
        }
    }
    
    func getNetworkCallType() -> NetworkCallType {
        return self.appGlobalStateStore.currentSelectedNetworkCallType
    }
    
    func setAskAISearchDifferenceResult(to: APIResponse<AskAIDifferenceQuestionResponse>?) {
        withAnimation {
            self.appGlobalStateStore.askAISearchDifferenceResponse = to
        }
    }
}
