import { Transform } from 'class-transformer';
import {
  ArrayMaxSize,
  ArrayMinSize,
  ArrayUnique,
  IsArray,
  IsNotEmpty,
  IsString,
  MaxLength,
} from 'class-validator';

function trimString(value: unknown): unknown {
  return typeof value === 'string' ? value.trim() : value;
}

function trimStringArray(value: unknown): unknown {
  if (!Array.isArray(value)) {
    return value;
  }

  const entries = value as unknown[];

  return entries.map((entry): unknown =>
    typeof entry === 'string' ? entry.trim() : entry,
  );
}

export class GetMCQAnswerRequestDto {
  @Transform(({ value }) => trimString(value))
  @IsString()
  @IsNotEmpty()
  @MaxLength(1_000)
  readonly question!: string;

  @Transform(({ value }) => trimStringArray(value))
  @IsArray()
  @ArrayMinSize(2)
  @ArrayMaxSize(10)
  @ArrayUnique()
  @IsString({ each: true })
  @IsNotEmpty({ each: true })
  @MaxLength(250, { each: true })
  readonly options!: string[];
}
