import { BadRequestException } from '@nestjs/common';
import AIConstants from './ai.constants';
import McqAnswerResponseDto from './models/dto/mcq-answer.response.dto';
import {
    AskAIXMLSchema,
    type AskAiXmlSchemaInterface,
} from './models/schemas/ask-ai-xml.schema';
import { XMLValidator, XMLParser } from 'fast-xml-parser';
import {
    AskAIDifferenceXMLSchema,
    AskAiDifferenceXmlSchemaInterface,
} from './models/schemas/ask-ai-difference-xml.schema';
import {
    AskAICodeXMLSchema,
    AskAiCodeXmlSchemaInterface,
} from './models/schemas/ask-ai-code-xml.schema';

export class AIHelper {
    private static readonly SUPPORTED_IMAGE_MIME_TYPES = new Set<string>(
        AIConstants.MCQ_IMAGE_ALLOWED_MIME_TYPES,
    );

    public static validateMCQImageUpload(
        file: Express.Multer.File | undefined,
    ): asserts file is Express.Multer.File {
        if (!file) {
            this.throwUploadValidationError(
                'Image upload failed',
                'An image file is required.',
            );
        }

        if (!this.SUPPORTED_IMAGE_MIME_TYPES.has(file.mimetype)) {
            this.throwUploadValidationError(
                'Invalid image format',
                'Only PNG, JPEG, or WEBP images are supported.',
            );
        }

        if (file.size > AIConstants.MCQ_IMAGE_MAX_FILE_SIZE_BYTES) {
            this.throwUploadValidationError(
                'Image too large',
                'The image must be 5 MB or smaller.',
            );
        }
    }

    private static throwUploadValidationError(
        message: string,
        explanation: string,
    ): never {
        throw new BadRequestException(
            McqAnswerResponseDto.failure(message, {
                optionNumber: 0,
                explanation,
                optionName: '',
            }),
        );
    }
    private static parseFromXML(xmlString: string): unknown {
        const xmlValidationResult = XMLValidator.validate(xmlString, {
            allowBooleanAttributes: false,
        });

        if (xmlValidationResult !== true)
            throw new Error('Invalid XML validation result!');

        const parser = new XMLParser({
            ignoreAttributes: false,
            attributeNamePrefix: '@_',
            parseTagValue: true,
            parseAttributeValue: true,
            trimValues: true,
            allowBooleanAttributes: false,
            processEntities: true,
            htmlEntities: false,
            ignoreDeclaration: false,
            ignorePiTags: false,
            cdataPropName: '__cdata',
            transformTagName: (name) => name,
            isArray: () => false,
        });

        return parser.parse(xmlString) as unknown;
    }

    public static parseAskAICodeXMLResponse(
        xmlString: string,
    ): AskAiCodeXmlSchemaInterface | null {
        const result = this.parseFromXML(xmlString);
        const parsedResult = AskAICodeXMLSchema.safeParse(result);
        if (parsedResult.success) return parsedResult.data;
        return null;
    }

    public static parseAskAIDifferenceXMLResponse(
        xmlString: string,
    ): AskAiDifferenceXmlSchemaInterface | null {
        const result = this.parseFromXML(xmlString);
        const parsedResult = AskAIDifferenceXMLSchema.safeParse(result);

        if (parsedResult.success) return parsedResult.data;
        return null;
    }

    public static parserAskAIXMLResponse(
        xmlString: string,
    ): AskAiXmlSchemaInterface | null {
        const result = this.parseFromXML(xmlString);
        const parsedResult = AskAIXMLSchema.safeParse(result);

        if (parsedResult.success) return parsedResult.data;
        return null;
    }
}
