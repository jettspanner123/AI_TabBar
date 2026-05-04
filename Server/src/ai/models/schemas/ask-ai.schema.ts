import { z } from 'zod';
import AIConstants from '../../ai.constants';

export const AskAISchema = z.object({
    response: z.string().describe(AIConstants.ASK_AI_SYSTEM_PROMPT),
});

export type AskAISchemaInfer = z.infer<typeof AskAISchema>;
