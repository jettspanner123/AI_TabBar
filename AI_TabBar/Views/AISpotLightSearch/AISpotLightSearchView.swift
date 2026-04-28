import SwiftUI

struct AISpotLightSearchView: View {
    
    @Environment(AppGlobalStateStore.self) private var appGlobalStateStore
    @State private var appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    @State private var aiSpotLightViewModel: AISpotLightSearchViewModel?
    
    @State private var searchQuery: String = ""
    @FocusState private var isAISpotLightTextFeildFocused: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VisualEffectView()
                .cornerRadius(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.app.opacity(0.35))
                }
            
            // MARK: This is the main thing
            VStack(spacing: .zero) {
                if self.appGlobalStateStoreObservable?.getSearchEntryState() == .LOADING {
                    AISpotLightSearchHeadingComponent(
                        appGlobalStateStoreObservable: self.appGlobalStateStoreObservable,
                        searchQuery: self.searchQuery
                    )
                    .transition(.blurReplace)
                } else {
                    AISpotLightSearchTextInputComponent(
                        searchQuery: self.$searchQuery,
                        appGlobalStateStoreObservable: self.appGlobalStateStoreObservable,
                        aiSpotLightViewModel: self.aiSpotLightViewModel
                    )
                    .transition(.blurReplace)
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(.clear)
        }
        .frame(height: self.appGlobalStateStoreObservable?.getDynamicExpandedWindowHeight())
        .background(.clear)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white.opacity(0.5), lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onChange(of: self.searchQuery) {
            self.aiSpotLightViewModel?.handleEmptySearchQueryState(query: searchQuery)
        }
        .onAppear {
            self.appGlobalStateStoreObservable = AppGlobalStateStoreObservable(appGlobalStateStore: self.appGlobalStateStore)
            self.aiSpotLightViewModel = AISpotLightSearchViewModel(appGlobalStateStore: self.appGlobalStateStore)
        }
    }
}
