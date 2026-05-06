//
//  AskAIQuestionCodeResponse.swift
//  AI_TabBar
//
//  Created by Uddeshya Singh on 06/05/26.
//

import Foundation

struct AskAICodeQuestionResponse: Codable {
    struct AskAICodeQuerstionRootResponse: Codable {
        public let Heading: String
        public let CodingLanguage: String
        public let Approach: AskAICodeQuestionApproachResponse
        public let BruteForceCode: String
        public let BruteForceCodeProsAndCons: AskAICodeQuestionProsAndConsResponse
        public let OptimisedCode: String
        public let OptimisedCodeProsAndCons: AskAICodeQuestionProsAndConsResponse
        public let CodeExplnation: String
        public let FollowUpQuestions: AskAICodeQuestionFollowUpQuestionsResponse
        
    }
    
    struct AskAICodeQuestionApproachResponse: Codable {
        public let Step: Array<String>
    }
    
    struct AskAICodeQuestionProsAndConsResponse: Codable {
        public let Pros: String
        public let Cons: String
    }
    
    struct AskAICodeQuestionFollowUpQuestionsResponse: Codable {
        public let Question: Array<String>
    }
    public let RootResponse: AskAICodeQuerstionRootResponse
}


