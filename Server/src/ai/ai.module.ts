import { Module } from '@nestjs/common';
import { AIController } from './ai.controller';
import { AIHelperService } from './services/ai-helper.service';
import { AIService } from './services/ai.service';

@Module({
    controllers: [AIController],
    providers: [AIService, AIHelperService],
})
export class AIModule {}
