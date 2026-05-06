import { z } from 'zod';

// When fast-xml-parser parses a CDATA section it produces { __cdata: "..." }
// so we accept either a plain string or that object shape.
const cdataOrString = z.union([
    z.string(),
    z.object({ __cdata: z.string() }).transform((v) => v.__cdata),
]);

export const AskAICodeXMLSchema = z.object({
    RootResponse: z.object({
        Heading: z.string(),
        CodingLanguage: z.string(),
        Approach: z.object({
            Step: z.array(z.string()),
        }),
        BruteForceCode: cdataOrString,
        BruteForceCodeProsAndCons: z.object({
            Pros: z.string(),
            Cons: z.string(),
        }),
        OptimisedCode: cdataOrString,
        OptimisedCodeProsAndCons: z.object({
            Pros: z.string(),
            Cons: z.string(),
        }),
        CodeExplnation: z.string(),
        FollowUpQuestions: z.object({
            Question: z.array(z.string()),
        }),
    }),
});

export type AskAiCodeXmlSchemaInterface = z.infer<typeof AskAICodeXMLSchema>;
