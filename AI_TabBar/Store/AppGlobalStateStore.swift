import Foundation

@Observable
class AppGlobalStateStore {
    var searchAreaExpantionState: AppSearchAreaExpantionState = .COLLAPSED
    var searchEntryState: AppSearchEntryState = .IDLE
    var searchMode: AppSearchMode = .SEARCH
    
    var currentSelectedNetworkCallType: NetworkCallType = .GENERAL
    var askAISearchResponse: Optional<APIResponse<AskAIQuestionResponse>> = nil
    var askAISearchDifferenceResponse: Optional<APIResponse<AskAIDifferenceQuestionResponse>> = nil
    var askAISearchCodeResponse: Optional<APIResponse<AskAICodeQuestionResponse>> = nil
}


enum AppSearchAreaExpantionState {
    case EXPANDED, COLLAPSED
}

enum AppSearchEntryState {
    case IDLE, TYPING, LOADING, SUCCESS, FAILURE
}

enum AppSearchMode: String,CaseIterable {
    case SEARCH, CHAT, AGENT, CONVERSATION
}
