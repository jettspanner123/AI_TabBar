import Foundation


@Observable
class AISpotLightSearchViewModel {
    private let appGlobalStateStore: AppGlobalStateStore
    private let appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    
    init(appGlobalStateStore: AppGlobalStateStore) {
        self.appGlobalStateStore = appGlobalStateStore
        self.appGlobalStateStoreObservable = AppGlobalStateStoreObservable(appGlobalStateStore: self.appGlobalStateStore)
    }
    
    func handleEmptySearchQueryState(query: String) -> Void {
        if query.isEmpty && self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED {
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .COLLAPSED)
        }
    }
    
    
    func search(with query: String) {
            
        if self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED {
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .COLLAPSED)
        }
        
        self.appGlobalStateStoreObservable?.setSearchEntryState(to: .LOADING)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.appGlobalStateStoreObservable?.setSearchEntryState(to: .IDLE)
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .EXPANDED)
        }
    }
}
