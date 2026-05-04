//
//  SectionHeader.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 05/05/26.
//

import SwiftUI

struct SectionHeader: View {
    var text: String
    var body: some View {
        Text(self.text)
            .font(.system(size: 15, weight: .bold, design: .rounded))
            .foregroundStyle(.white.opacity(0.5))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 5)
    }
}
