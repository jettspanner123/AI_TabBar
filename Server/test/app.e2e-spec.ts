import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from './../src/app.module';

describe('AppController (e2e)', () => {
  let app: INestApplication<App>;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        forbidNonWhitelisted: true,
        transform: true,
      }),
    );
    await app.init();
  });

  it('/ai/mcq (POST)', () => {
    return request(app.getHttpServer())
      .post('/ai/mcq')
      .send({
        question: 'What is 2 + 2?',
        options: ['3', '4', '5'],
      })
      .expect(200)
      .expect({
        status: 'not_implemented',
        answer: null,
        answerIndex: null,
        explanation:
          'MCQ endpoint is ready. AI answer generation has not been implemented yet for the 3-option question you submitted.',
      });
  });

  it('/ai/mcq (POST) rejects malformed payloads', () => {
    return request(app.getHttpServer())
      .post('/ai/mcq')
      .send({
        question: '',
        options: ['Only one option'],
      })
      .expect(400);
  });
});
