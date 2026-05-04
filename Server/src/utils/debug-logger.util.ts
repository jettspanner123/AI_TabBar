import EnvValidator from './env-validator.util';

export default class Logger {
    public static debugLog(...args: Array<unknown>) {
        if (EnvValidator.getEnv('AI_TAB_BAR_ENV') == EnvValidator.DEV_ENV) {
            console.log(...args);
        }
    }
}
