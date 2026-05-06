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
            Image(systemName: AppIconsConstants.current.MAGNIFYING_GLASS)
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .padding(.trailing, 10)
            
            
            CustomSegmentComponent(
                selectedSegment: self.$selectedRequestType,
                caseArray: NetworkCallType.allCases.map {$0.rawValue}
            )
            .padding(.trailing, 10)
            .padding(.leading, 5)
            
            HStack {
                
            }
            .frame(width: 1)
            .frame(maxHeight: .infinity)
            .background(.white.opacity(0.5))
            .padding(.vertical, 25)
            .padding(.trailing, 10)
            
            TextField("Search", text: self.$searchQuery)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 30, weight: .regular, design: .rounded))
                .padding(.vertical, 20)
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
            .padding(.horizontal, self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED ? 20 : 10)
            
        }
        .frame(maxWidth: .infinity)
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
