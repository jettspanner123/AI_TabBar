export default class AskAIResponse {
    private constructor(
        public readonly success: boolean,
        public readonly message: string,
        public readonly response: string,
    ) {}

    public static success(
        response: string,
        message = 'AI response generated',
    ): AskAIResponse {
        return new AskAIResponse(true, message, response);
    }

    public static failure(message: string, response: string): AskAIResponse {
        return new AskAIResponse(false, message, response);
    }
}
