//
//  AISpotLightSearchActionButtonComponent.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 06/05/26.
//

import Foundation
import SwiftUI

enum AISpotLightSearchActionButtonType {
    case SQUARE, CIRCLE
}

struct AISpotLightSearchActionButtonComponent: View {
    var image: String
    var type: AISpotLightSearchActionButtonType = .SQUARE
    var imageScale: CGFloat = 1.4
    var onTap: () async -> Void
    var body: some View {
        Button(action: {
            Task {
                await self.onTap()
            }
        }) {
            HStack {
                Image(systemName: self.image)
                    .scaleEffect(self.imageScale)
            }
            .frame(width: 40, height: 40)
        }
        .buttonStyle(.plain)
        .hoverBackground(
            normal: .white.opacity(0.1),
            hover: .white.opacity(0.2),
        )
        .clipShape(self.type == .SQUARE ? .rect(cornerRadius: 4) : .rect(cornerRadius: 200))
        .overlay {
            RoundedRectangle(cornerRadius: self.type == .SQUARE ? 4 : 200)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        }
    }
}
