import { Transform } from 'class-transformer';
import { IsNotEmpty, IsString, MaxLength } from 'class-validator';

function trimPrompt(value: unknown): unknown {
    return typeof value === 'string' ? value.trim() : value;
}

export default class AskAIRequest {
    @Transform(({ value }) => trimPrompt(value))
    @IsString()
    @IsNotEmpty()
    @MaxLength(4000)
    public readonly prompt!: string;
}
