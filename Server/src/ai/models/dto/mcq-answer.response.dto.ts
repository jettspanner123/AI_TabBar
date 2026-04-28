export default class MCQAnswerResponse {
    private constructor(
        public readonly success: boolean,
        public readonly message: string,
        public readonly optionNumber: number,
        public readonly explanation: string,
        public readonly optionName: string,
    ) {}

    static success(
        optionNumber: number,
        explanation: string,
        optionName: string,
        message = 'Answer identified',
    ): MCQAnswerResponse {
        return new MCQAnswerResponse(
            true,
            message,
            optionNumber,
            explanation,
            optionName,
        );
    }

    static failure(
        message: string,
        explanation: string,
        optionName: string,
    ): MCQAnswerResponse {
        return new MCQAnswerResponse(
            false,
            message,
            0,
            explanation,
            optionName,
        );
    }
}
