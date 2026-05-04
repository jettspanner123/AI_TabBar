import {
    Body,
    Controller,
    HttpException,
    Get,
    HttpCode,
    HttpStatus,
    Post,
    UploadedFile,
    UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { memoryStorage } from 'multer';
import { AIHelper } from './ai.helper';
import { AIService } from './services/ai.service';
import AIConstants from './ai.constants';
import AskAIRequest from './models/dto/ask-ai.request.dto';
import AskAIResponse from './models/dto/ask-ai.response.dto';
import MCQAnswerResponse from './models/dto/mcq-answer.response.dto';

@Controller('ai')
export class AIController {
    constructor(private readonly aiService: AIService) {}

    private getMCQFailureResponse(error: unknown): MCQAnswerResponse {
        if (error instanceof HttpException) {
            const response = error.getResponse();

            if (
                response &&
                typeof response === 'object' &&
                'success' in response &&
                'message' in response &&
                'data' in response
            ) {
                return response as MCQAnswerResponse;
            }

            if (
                response &&
                typeof response === 'object' &&
                'message' in response
            ) {
                const message = Array.isArray(response.message)
                    ? response.message.join(', ')
                    : String(response.message);

                return MCQAnswerResponse.failure(message);
            }
        }

        return MCQAnswerResponse.failure(
            error instanceof Error
                ? error.message
                : 'Failed to fetch data from AI',
        );
    }

    @Post('mcq')
    @HttpCode(HttpStatus.OK)
    @UseInterceptors(
        FileInterceptor(AIConstants.MCQ_IMAGE_FIELD_NAME, {
            storage: memoryStorage(),
        }),
    )
    async getMCQAnswer(
        @UploadedFile() file: Express.Multer.File | undefined,
    ): Promise<MCQAnswerResponse> {
        try {
            AIHelper.validateMCQImageUpload(file);
            return await this.aiService.getMCQAnswer(file);
        } catch (error) {
            return this.getMCQFailureResponse(error);
        }
    }

    @Post('ask')
    @HttpCode(HttpStatus.OK)
    async askAI(@Body() request: AskAIRequest): Promise<AskAIResponse> {
        try {
            return await this.aiService.askAI(request.prompt);
        } catch (error) {
            return AskAIResponse.failure(
                error instanceof Error ? error.message : String(error),
                null,
            );
        }
    }
}
