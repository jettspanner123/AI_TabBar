//
//  AISpotLightSearchCodeResultComponent.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 06/05/26.
//

import Foundation
import SwiftUI

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
