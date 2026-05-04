export interface MCQAnswerData {
    optionNumber: number;
    explanation: string;
    optionName: string;
}

export default class MCQAnswerResponse {
    private constructor(
        public readonly success: boolean,
        public readonly message: string,
        public readonly data: MCQAnswerData | null,
    ) {}

    static success(
        data: MCQAnswerData,
        message = 'Answer identified',
    ): MCQAnswerResponse {
        return new MCQAnswerResponse(true, message, data);
    }

    static failure(
        message: string,
        data: MCQAnswerData | null = null,
    ): MCQAnswerResponse {
        return new MCQAnswerResponse(false, message, data);
    }
}
