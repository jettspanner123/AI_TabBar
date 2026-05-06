import { Injectable } from '@nestjs/common';
import OpenAI from 'openai';
import EnvValidator from 'src/utils/env-validator.util';
import Instructor from '@instructor-ai/instructor';
import AIConstants from '../ai.constants';
import { generateText, Output } from 'ai';
import {
    GoogleGenerativeAIProvider,
    createGoogleGenerativeAI,
} from '@ai-sdk/google';
import { AskAISchema } from '../models/schemas/ask-ai.schema';
import { MCQAnswerSchema } from '../models/schemas/mcq-answer.schema';
import MCQAnswerResponse from '../models/dto/mcq-answer.response.dto';

@Injectable()
export class AIHelperService {
    private readonly openAIClient: OpenAI;
    private readonly instructorClient: ReturnType<typeof Instructor>;
    private readonly googleAIService: GoogleGenerativeAIProvider;

    constructor() {
        this.openAIClient = new OpenAI({
            apiKey: EnvValidator.getEnv(EnvValidator.GROQ_API_KEY),
            baseURL: AIConstants.GROQ_BASE_URL,
        });

        this.instructorClient = Instructor({
            client: this.openAIClient,
            mode: 'FUNCTIONS',
        });

        this.googleAIService = createGoogleGenerativeAI({
            apiKey: EnvValidator.getEnv('GOOGLE_API_KEY'),
        });
    }

    async getMCQAnswer(file: Express.Multer.File): Promise<MCQAnswerResponse> {
        const result = await generateText({
            model: this.googleAIService(AIConstants.AI_MODEL),
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
                            text: AIConstants.AI_MCQ_SYSTEM_PROMPT,
                        },
                    ],
                },
            ],
        });
        return MCQAnswerResponse.success({
            optionNumber: result.output.optionNumber,
            explanation: result.output.explanation,
            optionName: result.output.optionName,
        });
    }

    public async askAICode(prompt: string, provider: AIServiceProvider) {
        if (provider == AIServiceProvider.GOOGLE) {
            console.log('Ask AI Code Google Provier');
        } else if (provider == AIServiceProvider.GROQ) {
            console.log('Ask AI Code Groq Provider');
        }

        const result_t = await this.openAIClient.chat.completions.create({
            model: 'openai/gpt-oss-20b',
            messages: [
                {
                    role: 'system',
                    content: AIConstants.ASK_AI_CODE_SYSTEM_PROMPT,
                },
                {
                    role: 'user',
                    content: prompt,
                },
            ],
        });

        const result = result_t.choices[0]?.message.content;
        return result;
    }

    public async askAIDifference(prompt: string, provider: AIServiceProvider) {
        if (provider == AIServiceProvider.GOOGLE) {
            console.log('Ask AI Difference Google Provier');
        } else if (provider == AIServiceProvider.GROQ) {
            console.log('Ask AI Difference Groq Provider');
        }

        const result_t = await this.openAIClient.chat.completions.create({
            model: 'openai/gpt-oss-20b',
            messages: [
                {
                    role: 'system',
                    content: AIConstants.ASK_AI_DIFFERENCE_SYSTEM_PROMPT,
                },
                {
                    role: 'user',
                    content: prompt,
                },
            ],
        });
        const result = result_t.choices[0]?.message.content;

        return result;
    }

    public async askAI(
        prompt: string,
        provider: AIServiceProvider = AIServiceProvider.GROQ,
    ): Promise<string | null | undefined> {
        let result: string | null | undefined;

        if (provider == AIServiceProvider.GOOGLE) {
            const result_t = await generateText({
                model: this.googleAIService(AIConstants.AI_MODEL),
                output: Output.object({
                    schema: AskAISchema,
                }),
                prompt,
            });
            result = result_t.output.response;
        } else if (provider == AIServiceProvider.GROQ) {
            const result_t = await this.openAIClient.chat.completions.create({
                model: 'openai/gpt-oss-20b',
                messages: [
                    {
                        role: 'system',
                        content: AIConstants.ASK_AI_SYSTEM_PROMPT,
                    },
                    {
                        role: 'user',
                        content: prompt,
                    },
                ],
            });
            result = result_t.choices[0]?.message.content;
        }

        return result;
    }
}

export enum AIServiceProvider {
    GOOGLE,
    GROQ,
}
