import Foundation

@Observable
class AppGlobalStateStore {
    var searchAreaExpantionState: AppSearchAreaExpantionState = .COLLAPSED
    var searchEntryState: AppSearchEntryState = .IDLE
    
    var askAISearchResponse: Optional<APIResponse<AskAIQuestionResponse>> = nil
}


enum AppSearchAreaExpantionState {
    case EXPANDED, COLLAPSED
}

enum AppSearchEntryState {
    case IDLE, TYPING, LOADING, SUCCESS, FAILURE
}
