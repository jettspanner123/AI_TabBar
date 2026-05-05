import { AskAiCodeXmlSchemaInterface } from '../schemas/ask-ai-code-xml.schema';

export default class AskAICodeResponse {
    private constructor(
        public readonly success: boolean,
        public readonly message: string,
        public readonly data: AskAiCodeXmlSchemaInterface | null,
    ) {}

    public static success(
        data: AskAiCodeXmlSchemaInterface | null,
        message = 'AI response generated',
    ): AskAICodeResponse {
        return new AskAICodeResponse(true, message, data);
    }

    public static failure(
        message: string,
        data: AskAiCodeXmlSchemaInterface | null,
    ): AskAICodeResponse {
        return new AskAICodeResponse(false, message, data);
    }
}
