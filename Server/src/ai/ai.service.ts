import { Injectable } from '@nestjs/common';
import { GetMCQAnswerRequestDto } from './dto/get-mcq-answer.request.dto';
import { GetMCQAnswerResponseDto } from './dto/get-mcq-answer.response.dto';

@Injectable()
export class AIService {
  getMCQAnswer(request: GetMCQAnswerRequestDto): GetMCQAnswerResponseDto {
    return new GetMCQAnswerResponseDto(
      null,
      null,
      `MCQ endpoint is ready. AI answer generation has not been implemented yet for the ${request.options.length}-option question you submitted.`,
    );
  }
}
