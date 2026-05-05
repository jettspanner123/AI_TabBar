import { AskAiDifferenceXmlSchemaInterface } from '../schemas/ask-ai-difference-xml.schema';

export default class AskAIDifferenceResponse {
    private constructor(
        public readonly success: boolean,
        public readonly message: string,
        public readonly data: AskAiDifferenceXmlSchemaInterface | null,
    ) {}

    public static success(
        data: AskAiDifferenceXmlSchemaInterface | null,
        message = 'AI response generated',
    ): AskAIDifferenceResponse {
        return new AskAIDifferenceResponse(true, message, data);
    }

    public static failure(
        message: string,
        data: AskAiDifferenceXmlSchemaInterface | null,
    ): AskAIDifferenceResponse {
        return new AskAIDifferenceResponse(false, message, data);
    }
}
