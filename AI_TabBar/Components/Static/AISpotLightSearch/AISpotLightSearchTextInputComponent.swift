import Foundation
import SwiftUI


struct AISpotLightSearchTextInputComponent: View {
    
    @Binding var searchQuery: String
    @FocusState private var textFeildFocusState: Bool
    @State private var selectedRequestType: String = NetworkCallType.GENERAL.rawValue
    
    var appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    var aiSpotLightViewModel: AISpotLightSearchViewModel?
    var appSettingsStateStoreObservable: AppSettingsStateStoreObservable?
    
    
    func handleScreenShotSearchButton() async throws -> Void {
        let imageData = self.aiSpotLightViewModel?.takeAppScreenshot()
    }
    
    func handleAskAISubmit() async -> Void {
        switch NetworkCallType(rawValue: self.selectedRequestType) {
        case .DIFFERENCE:
            await self.aiSpotLightViewModel?.searchDifference(with: self.searchQuery)
        case .GENERAL:
            await self.aiSpotLightViewModel?.search(with: self.searchQuery)
        case .CODE:
            await self.aiSpotLightViewModel?.searchCode(with: self.searchQuery)
        default:
            return
        }
    }
    
    
    var body: some View {
        HStack(spacing: 0) {
            
            
            
            CustomSegmentComponent(
                selectedSegment: self.$selectedRequestType,
                caseArray: NetworkCallType.allCases.map {$0.rawValue}
            )
            .padding(.trailing, 10)
            .padding(.leading, 5)
            
            TextField("Search", text: self.$searchQuery)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 30, weight: .regular, design: .rounded))
                .padding(.vertical, 20)
                .padding(.leading, 10)
                .focused(self.$textFeildFocusState)
                .onSubmit {
                    Task {
                        await self.handleAskAISubmit()
                    }
                }
            
            Spacer()
            
            HStack {
                AISpotLightSearchActionButtonComponent(image: AppIconsConstants.current.CAMERA) {
                    Task {
                        try? await self.handleScreenShotSearchButton()
                    }
                }
                
                AISpotLightSearchActionButtonComponent(image: AppIconsConstants.current.SETTINGS) {
                    self.appSettingsStateStoreObservable?.handleShowSettingsView()
                }
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.top, self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED ? 0 : 5)
        .onChange(of: self.selectedRequestType) {
            self.appGlobalStateStoreObservable?.setNetworkCallType(to: NetworkCallType(rawValue: self.selectedRequestType) ?? .GENERAL)
        }
        .onAppear {
            DispatchQueue.main.async {
                self.textFeildFocusState = true
            }
        }
        .onDisappear {
            DispatchQueue.main.async {
                self.textFeildFocusState = false
            }
        }
    }
}
