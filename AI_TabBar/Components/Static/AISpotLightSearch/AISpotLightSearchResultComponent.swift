//
//  AISpotLightSearchResultComponent.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 06/05/26.
//

import Foundation
import SwiftUI

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
