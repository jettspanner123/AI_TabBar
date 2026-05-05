import Foundation


struct AskAIDifferenceQuestionResponse: Codable {
    public let RootResponse: AskAIDifferenceQuerstionRootResponse
}

struct AskAIDifferenceQuerstionRootResponse: Codable {
    public let Heading: String
    public let SingleLineDifference: String
    public let Topics: AskAIQuestionDifferenceTopicsResponse
    public let Differences: AskAIQuestionDifferenceDifferencesResponse
    public let FollowUpQuestions: AskAIQuestionsFollowUpQuestionResponse
}

struct AskAIQuestionDifferenceTopicsResponse: Codable {
    public let TopicOne: String
    public let TopicTwo: String
}

struct AskAIQuestionDifferenceDifferencesResponse: Codable {
    public let Difference: Array<AskAIQuestionDifferenceDifferencesPairResponse>
}

struct AskAIQuestionDifferenceDifferencesPairResponse: Codable {
    public let FirstTopicDifferencePoint: String
    public let SecondTopicDifferencePoint: String
}

struct AskAIDifferenceQuestionsFollowUpQuestionResponse: Codable {
    public let Question: Array<String>
}
