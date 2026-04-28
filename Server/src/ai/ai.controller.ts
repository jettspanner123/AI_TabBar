import {
    Body,
    Controller,
    HttpCode,
    HttpStatus,
    Post,
    UploadedFile,
    UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { memoryStorage } from 'multer';
import { AIHelper } from './ai.helper';
import { AIService } from './ai.service';
import AIConstants from './ai.constants';
import AskAIRequest from './models/dto/ask-ai.request.dto';
import AskAIResponse from './models/dto/ask-ai.response.dto';
import MCQAnswerResponse from './models/dto/mcq-answer.response.dto';

@Controller('ai')
export class AIController {
    constructor(private readonly aiService: AIService) {}

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
            return MCQAnswerResponse.failure(
                'Failed to fetch data from AI',
                error instanceof Error ? error.message : (error as string),
                '',
            );
        }
    }

    @Post('ask')
    @HttpCode(HttpStatus.OK)
    async askAI(@Body() request: AskAIRequest): Promise<AskAIResponse> {
        try {
            return await this.aiService.askAI(request.prompt);
        } catch (error) {
            return AskAIResponse.failure(
                'Failed to ask AI',
                error instanceof Error ? error.message : String(error),
            );
        }
    }
}
