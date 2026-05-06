import SwiftUI

struct AISpotLightSearchView: View {
    
    @Environment(AppGlobalStateStore.self) private var appGlobalStateStore
    @Environment(AppSettingsStateStore.self) private var appSettingsStateStore
    @State private var appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    @State private var aiSpotLightViewModel: AISpotLightSearchViewModel?
    @State private var appSettingsStateStoreObservable: AppSettingsStateStoreObservable?
    @State private var isSettingsSheetPresented: Bool = false
    
    @State private var searchQuery: String = ""
    @FocusState private var isAISpotLightTextFeildFocused: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VisualEffectView()
                .cornerRadius(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.app.opacity(0.5))
                }
            
            switch self.appGlobalStateStore.searchMode {
            case .AGENT:
                EmptyView()
            case .CHAT:
                AppChatModeView()
            case .SEARCH:
                AppSearchModeView(searchQuery: self.$searchQuery)
            }
        }
        .frame(height: self.appGlobalStateStoreObservable?.getDynamicExpandedWindowHeight())
        .background(.clear)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white.opacity(0.5), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onAppear {
            self.appGlobalStateStoreObservable = AppGlobalStateStoreObservable(appGlobalStateStore: self.appGlobalStateStore)
            self.aiSpotLightViewModel = AISpotLightSearchViewModel(appGlobalStateStore: self.appGlobalStateStore)
            self.appSettingsStateStoreObservable = AppSettingsStateStoreObservable(appSettingsStateStore: self.appSettingsStateStore, appGlobalStateStoreObservable: self.appGlobalStateStoreObservable)
        }
    }
}
