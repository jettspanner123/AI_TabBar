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
            
            
            AISpotLightSearchCustomSegmentComponent(
                selectedSegment: self.$selectedRequestType,
                caseArray: NetworkCallType.allCases.map {$0.rawValue}
            )
            .padding(.trailing, 10)
            .padding(.leading, 5)
            
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

struct AISpotLightSearchCustomSegmentComponent: View {
    @Binding var selectedSegment: String
    var caseArray: Array<String>
    var body: some View {
        HStack(spacing: 0) {
            ForEach(self.caseArray, id: \.self) { caseName in
                Text(caseName)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .hoverBackground(normal: self.selectedSegment == caseName ? .white.opacity(0.30) : .white.opacity(0.08), hover: .white.opacity(0.15))
                    .onTapGesture {
                        if self.selectedSegment == caseName { return }
                        withAnimation {
                            self.selectedSegment = caseName
                        }
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        }
    }
}

struct AISpotLightSearchActionButtonComponent: View {
    var image: String
    var onTap: () async -> Void
    var body: some View {
        Button(action: {
            Task {
                await self.onTap()
            }
        }) {
            HStack {
                Image(systemName: self.image)
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

struct AISpotLightSearchResultComponent: View {
    
    let result: APIResponse<AskAIQuestionResponse>
    
    var body: some View {
        if let rootResponse = result.data?.RootResponse {
            VStack {
                Text(rootResponse.Heading)
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                Text(rootResponse.SingleLineAnswer)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.white.opacity(0.09))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 1)
                
                SectionHeader(text: "Full Description")
                
                Text(rootResponse.DescriptiveAnswer)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.white.opacity(0.09))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                
                SectionHeader(text: "Follow Up Questions")
                
                ForEach(rootResponse.FollowUpQuestions.Question, id: \.self) { question in
                    HStack {
                        Text(question)
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: AppIconsConstants.current.CHEVRON_RIGHT)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .hoverBackground(normal: .white.opacity(0.03), hover: .white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 25)
        }
    }
}


struct AISpotLightSearchDifferenceResultComponent: View {
    
    let result: APIResponse<AskAIDifferenceQuestionResponse>
    
    var body: some View {
        if let rootResponse = result.data?.RootResponse {
            VStack {
                Text(rootResponse.Heading)
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                Text(rootResponse.SingleLineDifference)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.white.opacity(0.09))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 1)
                
                SectionHeader(text: "Full Difference")
                
                VStack {
                    HStack {
                        Text(rootResponse.Topics.TopicOne)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.white.opacity(0.09))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Text(rootResponse.Topics.TopicTwo)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.white.opacity(0.09))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 10)
                    
                    
                    ForEach(rootResponse.Differences.Difference.indices, id: \.self) { differenceIndex in
                        HStack {
                            Text(rootResponse.Differences.Difference[differenceIndex].FirstTopicDifferencePoint)
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(height: 65)
                                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .leading)
                                .padding()
                                .background(.white.opacity(0.02))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(alignment: .leading) {
                                    HStack {
                                        
                                    }
                                    .frame(width: 1)
                                    .frame(maxHeight: .infinity)
                                    .background(.white)
                                }
                            
                            Text(rootResponse.Differences.Difference[differenceIndex].SecondTopicDifferencePoint)
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(height: 65)
                                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .leading)
                                .padding()
                                .background(.white.opacity(0.02))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(alignment: .leading) {
                                    HStack {
                                        
                                    }
                                    .frame(width: 1)
                                    .frame(maxHeight: .infinity)
                                    .background(.white)
                                }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                SectionHeader(text: "Follow Up Questions")
                
                ForEach(rootResponse.FollowUpQuestions.Question, id: \.self) { question in
                    HStack {
                        Text(question)
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: AppIconsConstants.current.CHEVRON_RIGHT)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .hoverBackground(normal: .white.opacity(0.03), hover: .white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                
                
                // MARK: Spacer at bottom
                HStack {
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 25)
        }
    }
}


struct AISpotLightSearchCodeResultComponent: View {
    
    let result: APIResponse<AskAICodeQuestionResponse>
    
    var body: some View {
        if let rootResponse = result.data?.RootResponse {
            VStack {
                Text(rootResponse.Heading)
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                
                SectionHeader(text: "Brute Force Code")
                Text(rootResponse.BruteForceCode)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.white.opacity(0.09))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 1)
                HStack {
                    Text("Pros")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white.opacity(0.09))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("Cons")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white.opacity(0.09))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text(rootResponse.BruteForceCodeProsAndCons.Pros)
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(height: 65)
                                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .leading)
                                .padding()
                                .background(.white.opacity(0.02))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(alignment: .leading) {
                                    HStack {
                                        
                                    }
                                    .frame(width: 1)
                                    .frame(maxHeight: .infinity)
                                    .background(.white)
                                }
                    
                    Text(rootResponse.BruteForceCodeProsAndCons.Cons)
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(height: 65)
                                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .leading)
                                .padding()
                                .background(.white.opacity(0.02))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(alignment: .leading) {
                                    HStack {
                                        
                                    }
                                    .frame(width: 1)
                                    .frame(maxHeight: .infinity)
                                    .background(.white)
                                }
                }
                .frame(maxWidth: .infinity)
                
                SectionHeader(text: "Optimised Code")
                Text(rootResponse.OptimisedCode)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.white.opacity(0.09))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 1)
                HStack {
                    Text("Pros")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white.opacity(0.09))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("Cons")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white.opacity(0.09))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text(rootResponse.OptimisedCodeProsAndCons.Pros)
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(height: 65)
                                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .leading)
                                .padding()
                                .background(.white.opacity(0.02))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(alignment: .leading) {
                                    HStack {
                                        
                                    }
                                    .frame(width: 1)
                                    .frame(maxHeight: .infinity)
                                    .background(.white)
                                }
                    
                    Text(rootResponse.OptimisedCodeProsAndCons.Cons)
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(height: 65)
                                .frame(maxWidth: .infinity, maxHeight: 65, alignment: .leading)
                                .padding()
                                .background(.white.opacity(0.02))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(alignment: .leading) {
                                    HStack {
                                        
                                    }
                                    .frame(width: 1)
                                    .frame(maxHeight: .infinity)
                                    .background(.white)
                                }
                }
                .frame(maxWidth: .infinity)

                SectionHeader(text: "Full Difference")
                
                SectionHeader(text: "Follow Up Questions")
                
                ForEach(rootResponse.FollowUpQuestions.Question, id: \.self) { question in
                    HStack {
                        Text(question)
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: AppIconsConstants.current.CHEVRON_RIGHT)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .hoverBackground(normal: .white.opacity(0.03), hover: .white.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                
                
                // MARK: Spacer at bottom
                HStack {
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 25)
        }
    }
}
