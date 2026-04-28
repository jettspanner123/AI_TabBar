import Foundation
import SwiftUI
import AppKit

@Observable
class AISpotLightSearchViewModel {
    private let appGlobalStateStore: AppGlobalStateStore
    private let appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    
    
    init(appGlobalStateStore: AppGlobalStateStore) {
        self.appGlobalStateStore = appGlobalStateStore
        self.appGlobalStateStoreObservable = AppGlobalStateStoreObservable(appGlobalStateStore: self.appGlobalStateStore)
    }
    
    func handleEmptySearchQueryState(query: String) -> Void {
        if query.isEmpty && self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED {
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .COLLAPSED)
        }
    }
    
    func search(with query: String) {
            
        if self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED {
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .COLLAPSED)
        }
        
        self.appGlobalStateStoreObservable?.setSearchEntryState(to: .LOADING)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.appGlobalStateStoreObservable?.setSearchEntryState(to: .IDLE)
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .EXPANDED)
        }
    }
    
    func makeAIBackendRequest(imageData: Data?) {
        let response = NetworkService.current.post.getMultipleChoiseQuestionAnswer(imageData: imageData)
    }
    func takeAppScreenshot() -> Data? {
        let displayID = CGMainDisplayID()
        
        if let cgImage = CGDisplayCreateImage(displayID) {
            let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
            guard let pngData = bitmapRep.representation(using: .png, properties: [:]) else { return nil }
            
            let tempURL = FileManager.default.temporaryDirectory
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
            let dateString = formatter.string(from: Date())
            let fileURL = tempURL.appendingPathComponent("Screen_\(dateString).png")
            
            do {
                try pngData.write(to: fileURL)
                print("Screenshot saved successfully to \(fileURL.path)")
                
                // Open the screenshot so the user can see it
                NSWorkspace.shared.open(fileURL)
                
                let pasteboard = NSPasteboard.general
                pasteboard.clearContents()
                pasteboard.setData(pngData, forType: .png)
                
                return pngData
            } catch {
                print("Error saving screenshot: \(error)")
                return nil
            }
        } else {
            print("Failed to capture screen")
            return nil
        }
    }
}
