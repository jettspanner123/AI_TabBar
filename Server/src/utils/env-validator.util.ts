export default class EnvValidator {
    public static getEnv(key: string): string {
        const value: string | undefined = process.env[key];
        if (!value) throw new Error(`Enviornment Variable Not Found!: ${key}`);
        return value;
    }
}
