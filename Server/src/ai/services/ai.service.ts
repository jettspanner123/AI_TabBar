import AskAIResponse from '../models/dto/ask-ai.response.dto';
import MCQAnswerResponse from '../models/dto/mcq-answer.response.dto';
import { AIHelper } from '../ai.helper';
import { Injectable } from '@nestjs/common';
import { AIHelperService, AIServiceProvider } from './ai-helper.service';
import AskAIDifferenceResponse from '../models/dto/ask-ai-difference.response.dto';
import AskAICodeResponse from '../models/dto/ask-ai-code.response.dto';

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

    async askAICode(prompt: string): Promise<AskAICodeResponse> {
        const result = await this.aiHelperService.askAICode(
            prompt,
            AIServiceProvider.GROQ,
        );

        if (!result)
            return AskAICodeResponse.failure(
                'Failed Generating AI Response!',
                null,
            );

        const xmlParsedResponse = AIHelper.parseAskAICodeXMLResponse(result);

        if (xmlParsedResponse)
            return AskAICodeResponse.success(xmlParsedResponse);
        return AskAICodeResponse.failure('Failed To Parse XML!', null);
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
