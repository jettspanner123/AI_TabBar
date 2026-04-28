import SwiftUI



struct AISpotLightSearchTextInputComponent: View {
    
    @Binding var searchQuery: String
    @FocusState private var textFeildFocusState: Bool
    
    var appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    var aiSpotLightViewModel: AISpotLightSearchViewModel?
    
    
    func handleScreenShotSearchButton() async throws -> Void {
        let imageData = self.aiSpotLightViewModel?.takeAppScreenshot()
    }
    
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: AppIconsConstants.current.MAGNIFYING_GLASS)
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .padding(.trailing, 15)
            
            TextField("Search", text: self.$searchQuery)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 30, weight: .regular, design: .rounded))
                .padding(.vertical, 20)
                .focused(self.$textFeildFocusState)
                .onSubmit {
                    self.aiSpotLightViewModel?.search(with: "")
                }
            
            Spacer()
            
            HStack {
                AISpotLightSearchActionButtonComponent() {
                    Task {
                        try? await self.handleScreenShotSearchButton()
                    }
                }
            }
            .padding(.horizontal, self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED ? 20 : 10)
            
        }
        .frame(maxWidth: .infinity)
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

struct AISpotLightSearchActionButtonComponent: View {
    var onTap: () async -> Void
    var body: some View {
        Button(action: {
            Task {
                await self.onTap()
            }
        }) {
            HStack {
                Image(systemName: AppIconsConstants.current.CAMERA)
                    .resizable()
                    .frame(width: 20, height: 15)
            }
            .frame(width: 40, height: 40)
        }
        .buttonStyle(.plain)
        .hoverBackground(
            normal: .white.opacity(0.1),
            hover: .white.opacity(0.2),
        )
        .clipShape(.rect(cornerRadius: 4))
        .border(.white.opacity(0.1), width: 1)
    }
}

struct AISpotLightSearchHeadingComponent: View {
    var appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    var searchQuery: String
    
    var body: some View {
        HStack {
            Text(self.searchQuery)
                .font(.system(size: 30, weight: .regular, design: .rounded))
                .padding(20)
            
            Spacer()
            
            if self.appGlobalStateStoreObservable?.getSearchEntryState() == .LOADING {
                ProgressView()
                    .padding(.horizontal, 20)
                    .transition(.blurReplace)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
