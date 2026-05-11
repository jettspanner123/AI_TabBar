export default class BaseResponse {
    private constructor(
        public readonly success: boolean,
        public readonly message: string,
    ) {}

    public static success(message: string): BaseResponse {
        return new BaseResponse(true, message);
    }
    public static failure(message: string): BaseResponse {
        return new BaseResponse(false, message);
    }
}
