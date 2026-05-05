import AskAIResponse from '../models/dto/ask-ai.response.dto';
import MCQAnswerResponse from '../models/dto/mcq-answer.response.dto';
import { AIHelper } from '../ai.helper';
import { Injectable } from '@nestjs/common';
import { AIHelperService, AIServiceProvider } from './ai-helper.service';
import AskAIDifferenceResponse from '../models/dto/ask-ai-difference.response.dto';

@Injectable()
export class AIService {
    constructor(private readonly aiHelperService: AIHelperService) {}

    async getMCQAnswer(file: Express.Multer.File): Promise<MCQAnswerResponse> {
        return this.aiHelperService.getMCQAnswer(file);
    }

    async askAIDifference(prompt: string): Promise<AskAIDifferenceResponse> {
        const result = await this.aiHelperService.askAIDifference(
            prompt,
            AIServiceProvider.GROQ,
        );

        if (!result)
            return AskAIDifferenceResponse.failure(
                'Failed Generating AI Response!',
                null,
            );

        const xmlParsedResponse =
            AIHelper.parseAskAIDifferenceXMLResponse(result);
        return AskAIDifferenceResponse.success(xmlParsedResponse);
    }

    async askAI(prompt: string): Promise<AskAIResponse> {
        const result = await this.aiHelperService.askAI(
            prompt,
            AIServiceProvider.GROQ,
        );

        if (!result)
            return AskAIResponse.failure(
                'Failed Generating AI Response!',
                null,
            );

        const xmlParsedResponse = AIHelper.parserAskAIXMLResponse(result);
        return AskAIResponse.success(xmlParsedResponse);
    }
}
