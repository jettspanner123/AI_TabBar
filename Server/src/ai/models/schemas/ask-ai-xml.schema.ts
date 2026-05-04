import { z } from 'zod';

export const AskAIXMLSchema = z.object({
    RootResponse: z.object({
        Heading: z.string(),
        SingleLineAnswer: z.string(),
        DescriptiveAnswer: z.string(),
        FollowUpQuestions: z.object({
            Question: z.array(z.string()),
        }),
    }),
});

export type AskAiXmlSchemaInterface = z.infer<typeof AskAIXMLSchema>;
