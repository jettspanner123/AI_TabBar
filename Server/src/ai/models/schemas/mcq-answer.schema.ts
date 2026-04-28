import { z } from 'zod';

export const MCQAnswerSchema = z.object({
    optionNumber: z
        .int()
        .describe(
            'The option number of the correct option from the list of options.',
        ),
    optionName: z.string().describe('The text content of the option'),
    explanation: z
        .string()
        .describe('A single line of explanation for why the options selected.'),
});

export type MCQAnswerSchemaInfer = z.infer<typeof MCQAnswerSchema>;
