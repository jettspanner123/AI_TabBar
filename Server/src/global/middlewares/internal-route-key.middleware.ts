import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response } from 'express';
import MiddlewareConstants from 'src/global/constants/middleware.constants';
import BaseResponse from 'src/global/models/base.response';
import EnvValidator from 'src/utils/env-validator.util';

@Injectable()
export class InternalRouteKeyMiddleware implements NestMiddleware {
    use(req: Request, res: Response, next: () => void) {
        const internalRouteKey =
            req.headers[MiddlewareConstants.current.INTERNAL_ROUTE_KEY_HEADER];

        if (!internalRouteKey) {
            res.status(401).json({
                success: false,
                message: 'Missing Internal Route Key!',
            } satisfies BaseResponse);
            return;
        }

        if (
            EnvValidator.getEnv(EnvValidator.INTERNAL_ROUTE_KEY) !==
            internalRouteKey
        ) {
            res.status(401).json({
                success: false,
                message: 'Wrong Internal Route Key!',
            } satisfies BaseResponse);
            return;
        }
        next();
    }
}
