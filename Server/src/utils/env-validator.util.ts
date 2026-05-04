export default class EnvValidator {
    public static DEV_ENV: string = 'DEV_ENV';
    public static GROQ_API_KEY: string = 'AI_TAB_BAR_GROQ_API_KEY';
    public static GOOGLE_GEMINI_API_KEY: string = 'GOOGLE_API_KEY';
    public static getEnv(key: string): string {
        const value: string | undefined = process.env[key];
        if (!value) throw new Error(`Enviornment Variable Not Found!: ${key}`);
        return value;
    }
}
