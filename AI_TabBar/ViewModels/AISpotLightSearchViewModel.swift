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
    
    func searchDifference(with query: String) async -> Void {
        if self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED {
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .COLLAPSED)
        }
        
        self.appGlobalStateStoreObservable?.setAskAISearchDifferenceResult(to: nil)
        self.appGlobalStateStoreObservable?.setSearchEntryState(to: .LOADING)
        
        do {
            let data = try await NetworkService.current.get.getAISearchDifferenceAnswer(query: query)

            guard data.success, data.data != nil else {
                self.appGlobalStateStoreObservable?.setSearchEntryState(to: .FAILURE)
                return
            }

            self.appGlobalStateStoreObservable?.setAskAISearchDifferenceResult(to: data)
            self.appGlobalStateStoreObservable?.setSearchEntryState(to: .SUCCESS)
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .EXPANDED)
        } catch {
            print("Search error:", error)
            self.appGlobalStateStoreObservable?.setAskAISearchDifferenceResult(to: nil)
            self.appGlobalStateStoreObservable?.setSearchEntryState(to: .FAILURE)
        }
    }
    
    func search(with query: String) async -> Void {

        if self.appGlobalStateStoreObservable?.getSearchAreaExpantionState() == .EXPANDED {
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .COLLAPSED)
        }

        // Clear previous result before starting a new search
        self.appGlobalStateStoreObservable?.setAskAISearchResult(to: nil)
        self.appGlobalStateStoreObservable?.setSearchEntryState(to: .LOADING)

        do {
            let data = try await NetworkService.current.get.getAISearchAnswer(query: query)

            guard data.success, data.data != nil else {
                self.appGlobalStateStoreObservable?.setSearchEntryState(to: .FAILURE)
                return
            }

            self.appGlobalStateStoreObservable?.setAskAISearchResult(to: data)
            self.appGlobalStateStoreObservable?.setSearchEntryState(to: .SUCCESS)
            self.appGlobalStateStoreObservable?.setDynamicExpandedWindowHeight(to: .EXPANDED)
        } catch {
            // Network or decoding error — reset state instead of staying stuck on LOADING
            print("Search error:", error)
            self.appGlobalStateStoreObservable?.setSearchEntryState(to: .FAILURE)
        }
    }
    
    func makeAIBackendRequest(imageData: Data?) async throws {
        let response = try? await NetworkService.current.post.getMultipleChoiseQuestionAnswer(imageData: imageData)
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
