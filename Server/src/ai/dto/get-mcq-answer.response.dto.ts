export class GetMCQAnswerResponseDto {
  readonly status = 'not_implemented' as const;

  constructor(
    public readonly answer: string | null,
    public readonly answerIndex: number | null,
    public readonly explanation: string,
  ) {}
}
