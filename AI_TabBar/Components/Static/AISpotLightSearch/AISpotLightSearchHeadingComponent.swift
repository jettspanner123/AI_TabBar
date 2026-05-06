//
//  AISpotLightSearchHeadingComponent.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 06/05/26.
//

import Foundation
import SwiftUI

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
