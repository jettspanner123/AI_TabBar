import SwiftUI

struct AppSearchModeView: View {
    
    @Environment(AppGlobalStateStore.self) private var appGlobalStateStore
    @Environment(AppSettingsStateStore.self) private var appSettingsStateStore
    @State private var appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    @State private var aiSpotLightViewModel: AISpotLightSearchViewModel?
    @State private var appSettingsStateStoreObservable: AppSettingsStateStoreObservable?
    @State private var selectedAppModeSegment: String = AppSearchMode.SEARCH.rawValue
    
    @Binding var searchQuery: String
    
    
    var body: some View {
        ScrollView {
            // MARK: If not settings view then normal view
            if !self.appSettingsStateStore.isSettingsViewOpen {
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
                            aiSpotLightViewModel: self.aiSpotLightViewModel,
                            appSettingsStateStoreObservable: self.appSettingsStateStoreObservable
                        )
                        .transition(.blurReplace)
                    }
                    
                    CustomSegmentComponent(
                        selectedSegment: self.$selectedAppModeSegment,
                        caseArray: AppSearchMode.allCases.map(\.rawValue),
                        takeFullWidth: true
                    )
                    .padding(.horizontal, 20)
                    
                    switch self.appGlobalStateStoreObservable?.getNetworkCallType() {
                    case .CODE:
                        if let response = self.appGlobalStateStore.askAISearchCodeResponse,
                           self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED,
                           response.success,
                           response.data != nil {
                            AISpotLightSearchCodeResultComponent(
                                result: response
                            )
                        }
                    case .GENERAL:
                        if let response = self.appGlobalStateStore.askAISearchResponse,
                           self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED,
                           response.success,
                           response.data != nil {
                            AISpotLightSearchResultComponent(
                                result: response
                            )
                            .transition(.blurReplace)
                        }
                    case .DIFFERENCE:
                        if let response = self.appGlobalStateStore.askAISearchDifferenceResponse,
                           self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED,
                           response.success,
                           response.data != nil {
                            AISpotLightSearchDifferenceResultComponent(
                                result: response
                            )
                            .transition(.blurReplace)
                        }
                    case nil:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .offset(y: self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED ? 0 : -8)
                .transition(.blurReplace)
                
                // MARK: If settings view then settings view
            } else {
                AISpotLightSearchSettingsView()
                    .transition(.blurReplace)
            }
        }
        .onChange(of: self.searchQuery) {
            self.aiSpotLightViewModel?.handleEmptySearchQueryState(query: searchQuery)
        }
        .onAppear {
            self.appGlobalStateStoreObservable = AppGlobalStateStoreObservable(appGlobalStateStore: self.appGlobalStateStore)
            self.aiSpotLightViewModel = AISpotLightSearchViewModel(appGlobalStateStore: self.appGlobalStateStore)
            self.appSettingsStateStoreObservable = AppSettingsStateStoreObservable(appSettingsStateStore: self.appSettingsStateStore, appGlobalStateStoreObservable: self.appGlobalStateStoreObservable)
        }
        .scrollDisabled(self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() != .EXPANDED)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
