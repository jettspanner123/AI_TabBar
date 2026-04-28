import { Injectable } from '@nestjs/common';
import { AskAISchema } from './models/schemas/ask-ai.schema';
import {
    createGoogleGenerativeAI,
    GoogleGenerativeAIProvider,
} from '@ai-sdk/google';
import { generateText, Output } from 'ai';
import AskAIResponse from './models/dto/ask-ai.response.dto';
import EnvValidator from '../utils/env-validator.util';
import MCQAnswerResponse from './models/dto/mcq-answer.response.dto';
import { MCQAnswerSchema } from './models/schemas/mcq-answer.schema';

@Injectable()
export class AIService {
    readonly googleAIService: GoogleGenerativeAIProvider;

    constructor() {
        this.googleAIService = createGoogleGenerativeAI({
            apiKey: EnvValidator.getEnv('GOOGLE_API_KEY'),
        });
    }
    async getMCQAnswer(file: Express.Multer.File): Promise<MCQAnswerResponse> {
        const result = await generateText({
            model: this.googleAIService('gemini-2.5-flash'),
            output: Output.object({
                schema: MCQAnswerSchema,
            }),
            messages: [
                {
                    role: 'user',
                    content: [
                        {
                            type: 'image',
                            image: file.buffer,
                        },
                        {
                            type: 'text',
                            text: 'You are a B.Tech / B.E. Computer Science College student, you are present with a Multiple Choice Question, you need to answer the question with the best of your abilities, just make sure the context is set as a college student doing B.E. Computer Science, or B.Tech Computer Science. Make sure the explanation you provide should be why did you take this option over the others.',
                        },
                    ],
                },
            ],
        });
        return MCQAnswerResponse.success(
            result.output.optionNumber,
            result.output.explanation,
            result.output.optionName,
        );
    }

    async askAI(prompt: string): Promise<AskAIResponse> {
        const result = await generateText({
            model: this.googleAIService('gemini-2.5-flash'),
            output: Output.object({
                schema: AskAISchema,
            }),
            prompt,
        });
        return AskAIResponse.success(result.output.response);
    }
}
