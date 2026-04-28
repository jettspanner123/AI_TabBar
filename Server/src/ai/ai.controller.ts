import { Body, Controller, HttpCode, HttpStatus, Post } from '@nestjs/common';
import { AIService } from './ai.service';
import { GetMCQAnswerRequestDto } from './dto/get-mcq-answer.request.dto';
import { GetMCQAnswerResponseDto } from './dto/get-mcq-answer.response.dto';

@Controller('ai')
export class AIController {
  constructor(private readonly aiService: AIService) {}

  @Post('mcq')
  @HttpCode(HttpStatus.OK)
  getMCQAnswer(
    @Body() request: GetMCQAnswerRequestDto,
  ): GetMCQAnswerResponseDto {
    return this.aiService.getMCQAnswer(request);
  }
}
