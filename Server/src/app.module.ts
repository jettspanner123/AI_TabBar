import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AIModule } from './ai/ai.module';
import { PathLoggerMiddleware } from './path-logger/path-logger.middleware';

@Module({
    imports: [AIModule],
})
export class AppModule implements NestModule {
    configure(consumer: MiddlewareConsumer) {
        consumer.apply(PathLoggerMiddleware).forRoutes('*');
    }
}
