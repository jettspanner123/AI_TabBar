export default class AIConstants {
    public static readonly MCQ_IMAGE_FIELD_NAME: string = 'image';

    public static readonly MCQ_IMAGE_MAX_FILE_SIZE_BYTES: number =
        5 * 1024 * 1024;

    public static readonly MCQ_IMAGE_ALLOWED_MIME_TYPES: Array<string> = [
        'image/jpeg',
        'image/png',
        'image/webp',
    ] as const;
}
