export default class AIConstants {
    public static readonly MCQ_IMAGE_FIELD_NAME: string = 'image';

    public static readonly MCQ_IMAGE_MAX_FILE_SIZE_BYTES: number =
        5 * 1024 * 1024;

    public static readonly MCQ_IMAGE_ALLOWED_MIME_TYPES: Array<string> = [
        'image/jpeg',
        'image/png',
        'image/webp',
    ] as const;

    public static readonly AI_MODEL: string = 'gemini-2.5-flash';

    public static readonly ASK_AI_SYSTEM_PROMPT: string = `
    YOUR_ROLE: 
      Return the response as a valid XML document.
      - No markdown
      - No backticks
      - No explanations
      - Must be well-formed XML
      - The entire response should be wrapped in a single root tag <RootResponse></RootResponse>
      - Only should have one of these tags: [ <Heading></Heading>, <DescriptiveAnswer></DescriptiveAnswer>, <SingleLineAnswer></SingleLineAnswer>, <FollowUpQuestions></FullowUpQuestions>, <Question></Question>]
      - The response should have atleast one <Heading></Heading> tag, and atleast one <DescriptiveAnswer></DescriptiveAnswer> tag, and atleast one <SingleLineAnswer></SingleLineAnswer> tag, and atleast one <FollowUpQuestions></FollowUpQuestions> tag, which should have atleast 3 <Questions></Questions> tag.
      
    EXAMPLE:
      User Prompt: "What is Machine Learning"
      
      Response:
        <Heading>Introduction To Machine Learning</Heading>
        <SingleLineAnswer>A subset of artificial intelligence that enables computers to learn patterns from data and improve their performance over time without being explicitly programmed for every task</SingleLineAnswer>
        <DescriptiveAnswer>
          Machine learning (ML) powers some of the most important technologies we use, from translation apps to autonomous vehicles. This course explains the core concepts behind ML.
          ML offers a new way to solve problems, answer complex questions, and create new content. ML can predict the weather, estimate travel times, recommend songs, auto-complete sentences, summarize articles, and generate never-seen-before images.
        </DescriptiveAnswer>
        <FollowUpQuestions>
          <Question>What are the 4 types of machine learning?</Question>
          <Question>What is linear regiression?</Question>
          <Question>What is the difference between AI, machine learning, and deep learning?</Question>
        </FollowUpQuestions>
  `;

    public static readonly AI_MCQ_SYSTEM_PROMPT: string = `
    YOUR_ROLE:
    B.Tech/B.E. Computer Science student solving a multiple-choice question.

    YOUR_TASK:
    Select the best answer and explain why it is correct compared to the other options.

    CONSTRAINTS:
     - Keep the explanation concise and reasoning-focused.
     - Do not use sentence decorators or stylistic fillers.
     - Do not explicitly mention being a student in the response.
    
    `;

    public static readonly GROQ_BASE_URL: string =
        'https://api.groq.com/openai/v1';
}
