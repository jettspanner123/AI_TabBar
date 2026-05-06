import AskAIResponse from '../models/dto/ask-ai.response.dto';
import MCQAnswerResponse from '../models/dto/mcq-answer.response.dto';
import { AIHelper } from '../ai.helper';
import { Injectable } from '@nestjs/common';
import { AIHelperService, AIServiceProvider } from './ai-helper.service';
import AskAIDifferenceResponse from '../models/dto/ask-ai-difference.response.dto';
import AskAICodeResponse from '../models/dto/ask-ai-code.response.dto';
import AIConstants from '../ai.constants';

@Injectable()
export class AIService {
    constructor(private readonly aiHelperService: AIHelperService) {}

    async getMCQAnswer(file: Express.Multer.File): Promise<MCQAnswerResponse> {
        return this.aiHelperService.getMCQAnswer(file);
    }

    async askAIDifference(prompt: string): Promise<AskAIDifferenceResponse> {
        let lastError: string = 'Failed Generating AI Response!';

        for (
            let attempt = 0;
            attempt < AIConstants.AI_REFETCH_LIMIT;
            attempt++
        ) {
            let result: string | null | undefined;

            try {
                result = await this.aiHelperService.askAIDifference(
                    prompt,
                    AIServiceProvider.GROQ,
                );
            } catch (e) {
                lastError = e instanceof Error ? e.message : String(e);
                continue;
            }

            if (!result) {
                lastError = 'Failed Generating AI Response!';
                continue;
            }

            try {
                const xmlParsedResponse =
                    AIHelper.parseAskAIDifferenceXMLResponse(result);
                if (xmlParsedResponse) {
                    return AskAIDifferenceResponse.success(xmlParsedResponse);
                }
                lastError = 'Failed To Parse XML!';
            } catch (e) {
                lastError = e instanceof Error ? e.message : String(e);
            }
        }

        return AskAIDifferenceResponse.failure(lastError, null);
    }

    async askAICode(prompt: string): Promise<AskAICodeResponse> {
        let lastError: string = 'Failed Generating AI Response!';

        for (
            let attempt = 0;
            attempt < AIConstants.AI_REFETCH_LIMIT;
            attempt++
        ) {
            let result: string | null | undefined;

            try {
                result = await this.aiHelperService.askAICode(
                    prompt,
                    AIServiceProvider.GROQ,
                );
            } catch (e) {
                lastError = e instanceof Error ? e.message : String(e);
                continue;
            }

            if (!result) {
                lastError = 'Failed Generating AI Response!';
                continue;
            }

            try {
                const xmlParsedResponse =
                    AIHelper.parseAskAICodeXMLResponse(result);
                if (xmlParsedResponse) {
                    return AskAICodeResponse.success(xmlParsedResponse);
                }
                lastError = 'Failed To Parse XML!';
            } catch (e) {
                lastError = e instanceof Error ? e.message : String(e);
            }
        }

        return AskAICodeResponse.failure(lastError, null);
    }

    async askAI(prompt: string): Promise<AskAIResponse> {
        let lastError: string = 'Failed Generating AI Response!';

        for (
            let attempt = 0;
            attempt < AIConstants.AI_REFETCH_LIMIT;
            attempt++
        ) {
            let result: string | null | undefined;

            try {
                result = await this.aiHelperService.askAI(
                    prompt,
                    AIServiceProvider.GROQ,
                );
            } catch (e) {
                lastError = e instanceof Error ? e.message : String(e);
                continue;
            }

            if (!result) {
                lastError = 'Failed Generating AI Response!';
                continue;
            }

            try {
                const xmlParsedResponse =
                    AIHelper.parserAskAIXMLResponse(result);
                if (xmlParsedResponse) {
                    return AskAIResponse.success(xmlParsedResponse);
                }
                lastError = 'Failed To Parse XML!';
            } catch (e) {
                lastError = e instanceof Error ? e.message : String(e);
            }
        }

        return AskAIResponse.failure(lastError, null);
    }
}
