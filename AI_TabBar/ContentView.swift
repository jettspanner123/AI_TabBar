//
//  ContentView.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 27/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    let presets: Array<( name: String, image: String )> = [
        ("Coding", "desktopcomputer"),
        ("Design", "paintbrush.pointed.fill"),
        ("Writing", "pencil.circle.fill"),
        ("Interview", "person.fill")
    ]
    
    let advancedOptions: Array<( name: String, image: String )> = [
        ("Full Screen Shot", "photo.fill"),
        ("Summerise Text", "document.fill"),
    ]
    
    
    
    let showText_t: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    
    @State private var searchText: String = ""
    @State private var currentSelectedPreset: Int = 0
    @State private var currentSelectedAdvancedOption: Int = 0
    
    // MARK: Hover index
    @State private var currentSelectedPresetHoverIndex: Int? = nil
    @State private var currentSelectedAdvancedHoverIndex: Int? = nil
    
    
    
    
    // MARK: Result States
    @State private var showResultScreen: Bool = false
    @State private var resultText: String = ""
    
    
    @State private var isLoading: Bool = false
    @FocusState private var searchBarFocusedState: Bool
    
    var showText: Bool {
        return self.searchText == "Hello" ? true : false
    }
    
    func aiSearch() -> Void {
        Task {
            
            
            
            let res: ApplicationAIResponse = await ApplicationAI.current.generateResponseFrom(text: self.searchText, mood: self.presets[self.currentSelectedPreset].name, explaination: true)
            
            if let err = res.error {
                print("Error Occured: ", err)
                return
            }
            
            withAnimation {
                self.isLoading = false
                self.resultText = res.response!
            }
            
            
        }
    }
    
    func selectionPresetThroughKeyPress() -> Void {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 126 && (self.currentSelectedPreset > 0) {
                self.currentSelectedPreset -= 1
                return nil
            } else if event.keyCode == 125 && (self.currentSelectedPreset < self.presets.count - 1) {
                self.currentSelectedPreset += 1
                return nil
            } else if event.keyCode == 116 && (self.currentSelectedAdvancedOption > 0) {
                self.currentSelectedAdvancedOption -= 1
            } else if event.keyCode == 121 && (self.currentSelectedAdvancedOption < self.advancedOptions.count - 1) {
                self.currentSelectedAdvancedOption += 1
            } else if event.keyCode == 36 {
                if self.searchText.isEmpty || self.searchText.count < 5 {
                    return nil
                }
                withAnimation(.smooth(duration: 1)) {
                    self.showResultScreen = true
                    self.isLoading = true
                }
                self.aiSearch()
            } else if event.keyCode == 53 {
                withAnimation {
                    if self.showResultScreen {
                        self.showResultScreen = false
                    }
                }
            }
            return event
        }
    }
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VisualEffectView()
                .cornerRadius(12)
                .shadow(radius: 20)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.black.opacity(0.2))
                }
            
            VStack(spacing: 0) {
                
                
                
                // MARK: This is the search bar
                TextField("Search", text: self.$searchText)
                    .focused(self.$searchBarFocusedState)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.title)
                    .padding(.horizontal, 30)
                    .overlay(alignment: .leading) {
                        HStack {
                            Image(systemName: self.showResultScreen ? "arrow.left" : "magnifyingglass")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .contentTransition(.symbolEffect)
                                .onTapGesture {
                                    withAnimation {
                                        if self.showResultScreen {
                                            self.showResultScreen = false
                                        }
                                    }
                                }
                            Spacer()
                            
                            if !self.showResultScreen {
                                Image(systemName: "paperplane.fill")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .rotationEffect(.degrees(45))
                                    .foregroundStyle(self.searchText.isEmpty || self.searchText.count < 5 ? .white.opacity(0.15) : .white)
                                    .padding(10)
                                    .background(self.searchText.isEmpty || self.searchText.count < 5 ? .clear : .white.opacity(0.1), in: RoundedRectangle(cornerRadius: 5))
                                    .transition(.offset(x: 100))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    .padding([.top, .leading], 15)
                    .padding(.trailing, 10)
                    
                
                Divider()
                    .tint(.white.opacity(0.5))
                    .padding(.top, 15)
                
                if self.showResultScreen {
                    self.resultView
                } else {
                    self.homeView
                        .onAppear {
                            DispatchQueue.main.async {
                                self.searchBarFocusedState = true
                            }
                        }
                        .onDisappear {
                            DispatchQueue.main.async {
                                self.searchBarFocusedState = false
                            }
                        }
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            
        }
        .frame(width: 700)
        .background(.clear)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white.opacity(0.5), lineWidth: 0.5)
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onAppear {
            self.selectionPresetThroughKeyPress()
        }
    }
    
    var resultView: some View {
        VStack {
            if self.isLoading {
               ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    Text(self.resultText)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.75))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    var homeView: some View {
        // MARK: THese are the options
        VStack(spacing: 0) {
            
            
            
            
            // MARK: Presets
            SectionHeading(text: "Presets")
            
            ForEach(Array(self.presets.enumerated()), id: \.offset) { index, item in
                HStack {
                    Image(systemName: item.image)
                        .frame(maxWidth: 20)
                        .frame(width: 20)
                    Text(item.0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(self.presets[self.currentSelectedPreset].0 == item.0 ? .white.opacity(0.1) : .clear, in: RoundedRectangle(cornerRadius: 5))
                .background(self.currentSelectedPresetHoverIndex == index ? .white.opacity(0.05) : .clear, in: RoundedRectangle(cornerRadius: 5))
                .onTapGesture {
                    withAnimation {
                        self.currentSelectedPreset = index
                    }
                }
                .onHover { isHovered in
                    withAnimation {
                        if isHovered {
                            self.currentSelectedPresetHoverIndex = index
                        } else {
                            self.currentSelectedPresetHoverIndex = nil
                        }
                    }
                }
            }
            
            
            
            
            // MARK: Advansed Options
            SectionHeading(text: "Advanced Options")
                .padding(.top, 10)
            
            ForEach(Array(self.advancedOptions.enumerated()), id: \.offset) { index, item in
                HStack {
                    Image(systemName: item.image)
                        .frame(maxWidth: 20)
                        .frame(width: 20)
                    Text(item.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background(self.advancedOptions[self.currentSelectedAdvancedOption].0 == item.0 ? .white.opacity(0.1) : .clear, in: RoundedRectangle(cornerRadius: 5))
                .background(self.currentSelectedAdvancedHoverIndex == index ? .white.opacity(0.05) : .clear, in: RoundedRectangle(cornerRadius: 5))
                .onTapGesture {
                    withAnimation {
                        self.currentSelectedAdvancedOption = index
                    }
                }
                .onHover { isHoverd in
                    withAnimation {
                        if isHoverd {
                            self.currentSelectedAdvancedHoverIndex = index
                        } else {
                            self.currentSelectedAdvancedHoverIndex = nil
                        }
                    }
                }
            }
            
        }
        .padding()
        
    }
}

struct SectionHeading: View {
    var text: String
    var body: some View {
        Text(self.text)
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .foregroundStyle(.white.opacity(0.5))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 5)
            .padding(.bottom, 10)
    }
}

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = .hudWindow    // try .sidebar, .popover, .menu, etc.
        view.blendingMode = .behindWindow
        view.state = .active
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}
