//
//  AISpotLightSearchSettingsView.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 05/05/26.
//

import SwiftUI

struct AISpotLightSearchSettingsView: View {
    
    @Environment(AppSettingsStateStore.self) private var appSettingsStateStore
    @Environment(AppGlobalStateStore.self) private var appGlobalStateStore
    @State var appSettingsStateStoreObservable: AppSettingsStateStoreObservable?
    @State var appGlobalStateStoreObservable: AppGlobalStateStoreObservable?
    
    var body: some View {
        VStack {
            HStack {
                AISpotLightSearchActionButtonComponent(image: AppIconsConstants.current.CHEVRON_LEFT, type: .CIRCLE) {
                    self.appSettingsStateStoreObservable?.handleHideSettingsView()
                }
                
                Spacer()
                
                Text("Settings")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                AISpotLightSearchActionButtonComponent(image: AppIconsConstants.current.CHEVRON_LEFT) {
                    
                }
                .opacity(0)
                
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .onAppear {
            self.appGlobalStateStoreObservable = AppGlobalStateStoreObservable(appGlobalStateStore: self.appGlobalStateStore)
            self.appSettingsStateStoreObservable = AppSettingsStateStoreObservable(
                appSettingsStateStore: self.appSettingsStateStore,
                appGlobalStateStoreObservable: self.appGlobalStateStoreObservable
            )
        }
    }
}
