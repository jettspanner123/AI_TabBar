import { z } from 'zod';

export const AskAISchema = z.object({
    response: z
        .string()
        .describe('The direct text response to the user prompt.'),
});

export type AskAISchemaInfer = z.infer<typeof AskAISchema>;
