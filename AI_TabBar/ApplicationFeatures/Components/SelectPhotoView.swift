//
//  SelectPhotoView.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 01/10/25.
//

import SwiftUI

struct SelectPhotoView: View {
    
    @State var isHovering: Bool = false
    @State var currentSelectedFilePathLoading: Bool = false
    @State var currentSelectedFilePath: String? = nil
    
    func openFileDialog() -> Void {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.allowedContentTypes = [.image]
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        
        
        withAnimation {
            self.currentSelectedFilePathLoading = true
        }
        
        defer {
            withAnimation {
                self.currentSelectedFilePathLoading = false
            }
        }
        
        panel.begin { response in
            if response == .OK {
                if let url = panel.url {
                    withAnimation {
                        self.currentSelectedFilePath = url.path()
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        HStack {
            HStack {
                
                if self.currentSelectedFilePathLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    VStack {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .frame(width: 45, height: 35)
                            .foregroundStyle(self.isHovering ? .white.opacity(0.5) : .white.opacity(0.25))
                        
                        Text("Upload Photo")
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                            .foregroundStyle(self.isHovering ? .white.opacity(0.5) : .white.opacity(0.25))
                            .padding(.top, 5)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                (self.isHovering ? .white.opacity(0.1) : .white.opacity(0.05)),
                in: RoundedRectangle(cornerRadius: 8)
            )
            .onHover { hover in
                self.isHovering = hover
                ApplicationUIHelper.current.togglePointerOnHover(hover: hover)
            }
            .padding()
            .onTapGesture {
                self.openFileDialog()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

