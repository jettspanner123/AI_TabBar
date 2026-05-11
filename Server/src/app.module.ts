import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AIModule } from './ai/ai.module';
import { InternalRouteKeyMiddleware } from './global/middlewares/internal-route-key.middleware';
import { PathLoggerMiddleware } from './global/middlewares/path-logger.middleware';

@Module({
    imports: [AIModule],
})
export class AppModule implements NestModule {
    configure(consumer: MiddlewareConsumer) {
        consumer
            .apply(PathLoggerMiddleware, InternalRouteKeyMiddleware)
            .forRoutes('*');
    }
}
