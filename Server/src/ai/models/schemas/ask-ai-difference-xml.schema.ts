import { z } from 'zod';

export const AskAIDifferenceXMLSchema = z.object({
    RootResponse: z.object({
        Heading: z.string(),
        SingleLineDifference: z.string(),
        Topics: z.object({
            TopicOne: z.string(),
            TopicTwo: z.string(),
        }),
        Differences: z.object({
            Difference: z.array(
                z.object({
                    FirstTopicDifferencePoint: z.string(),
                    SecondTopicDifferencePoint: z.string(),
                }),
            ),
        }),
        FollowUpQuestions: z.object({
            Question: z.array(z.string()),
        }),
    }),
});

export type AskAiDifferenceXmlSchemaInterface = z.infer<
    typeof AskAIDifferenceXMLSchema
>;
