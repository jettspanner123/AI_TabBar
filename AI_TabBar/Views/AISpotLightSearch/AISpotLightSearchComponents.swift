import SwiftUI



struct AISpotLightSearchTextInputComponent: View {
    
    @Binding var searchQuery: String
    
    var appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    var aiSpotLightViewModel: AISpotLightSearchViewModel?
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: AppIconsConstants.current.MAGNIFYING_GLASS)
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.leading, 20)
                .padding(.trailing, 10)
            
            TextField("Search", text: self.$searchQuery)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 30, weight: .regular, design: .rounded))
                .padding(.vertical, 20)
                .onSubmit {
                    self.aiSpotLightViewModel?.search(with: "")
                }
            
            if self.appGlobalStateStoreObservable?.getSearchEntryState() == .LOADING {
                ProgressView()
                    .padding(.horizontal, 20)
                    .transition(.blurReplace)
            }
            
        }
        .frame(maxWidth: .infinity)
    }
}

struct AISpotLightSearchHeading: View {
    
    var searchQuery: String
    
    var body: some View {
        Text(self.searchQuery)
            .font(.system(size: 30, weight: .regular, design: .rounded))
            .padding(.vertical, 20)
    }
}
