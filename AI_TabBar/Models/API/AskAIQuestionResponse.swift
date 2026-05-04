import Foundation
import SwiftUI


struct AskAIQuestionResponse: Codable {
    public let RootResponse: AskAIQuerstionRootResponse
}

struct AskAIQuerstionRootResponse: Codable {
    public let Heading: String
    public let SingleLineAnswer: String
    public let DescriptiveAnswer: String
    public let FollowUpQuestions: AskAIQuestionsFollowUpQuestionResponse
}

struct AskAIQuestionsFollowUpQuestionResponse: Codable {
    public let Question: Array<String>
}
