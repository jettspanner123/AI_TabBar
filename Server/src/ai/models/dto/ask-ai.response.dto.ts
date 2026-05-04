import { AskAiXmlSchemaInterface } from '../schemas/ask-ai-xml.schema';

export default class AskAIResponse {
    private constructor(
        public readonly success: boolean,
        public readonly message: string,
        public readonly data: AskAiXmlSchemaInterface | null,
    ) {}

    public static success(
        data: AskAiXmlSchemaInterface | null,
        message = 'AI response generated',
    ): AskAIResponse {
        return new AskAIResponse(true, message, data);
    }

    public static failure(
        message: string,
        data: AskAiXmlSchemaInterface | null,
    ): AskAIResponse {
        return new AskAIResponse(false, message, data);
    }
}
