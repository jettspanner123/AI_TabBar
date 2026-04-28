import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

const DEFAULT_PORT = 3000;

function resolvePort(portValue: string | undefined): number {
    if (!portValue) {
        return DEFAULT_PORT;
    }

    const parsedPort = Number.parseInt(portValue, 10);

    if (Number.isInteger(parsedPort) && parsedPort > 0) {
        return parsedPort;
    }

    return DEFAULT_PORT;
}

async function bootstrap() {
    const app = await NestFactory.create(AppModule, {
        bufferLogs: true,
    });

    app.useGlobalPipes(
        new ValidationPipe({
            whitelist: true,
            forbidNonWhitelisted: true,
            transform: true,
            transformOptions: {
                enableImplicitConversion: false,
            },
        }),
    );

    app.enableShutdownHooks();

    await app.listen(resolvePort(process.env.PORT));
}

void bootstrap();
