import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response } from 'express';

@Injectable()
export class PathLoggerMiddleware implements NestMiddleware {
    use(req: Request, res: Response, next: () => void) {
        console.log(
            `INTERNAL_ROUTE_HIT_OCCURED::[${req.method.toUpperCase()}] ${req.originalUrl} -> ${res.statusCode}`,
        );
        next();
    }
}
