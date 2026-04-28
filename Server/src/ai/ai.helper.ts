import { BadRequestException } from '@nestjs/common';
import AIConstants from './ai.constants';
import McqAnswerResponseDto from './models/dto/mcq-answer.response.dto';

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
            McqAnswerResponseDto.failure(message, explanation, ''),
        );
    }
}
