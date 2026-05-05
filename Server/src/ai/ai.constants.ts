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

    public static readonly ASK_AI_DIFFERENCE_SYSTEM_PROMPT: string = `
    YOUR_ROLE: 
      Return the response as a valid XML document.
      - No markdown
      - No backticks
      - No explanations
      - Must be well-formed XML
      - The entire response should be wrapped in a single root tag <RootResponse></RootResponse>
      - Only should have one of these tags: [ <Heading></Heading>, <SingleLineDifference></SingleLineDifference>,<Topics></Topics>, <TopicOne></TopicOne>,<TopicTwo></TopicTwo> ,<Differences></Differences>,<FirstTopicDifferencePoint></FirstTopicDifferencePoint>, <SecondTopicDifferencePoint></SecondTopicDifferencePoint>,<FollowUpQuestions></FullowUpQuestions>, <Question></Question>]
      - The response should have atleast one <Heading></Heading> tag, and atleast one <SingleLineDifference></SingleLineDifference> tag, and atleast one <Differences></Differences> tag, and atleast one <FirstTopicDifferencePoint></FirstTopicDifferencePoint> tag, and atleast one <SecondTopicDifferencePoint></SecondTopicDifferencePoint> tag, and atleast one <FollowUpQuestions></FollowUpQuestions> tag, which should have atleast 3 <Questions></Questions> tag.
      
    EXAMPLE:
      User Prompt: "What is the difference between HTML and CSS?"

    TAGS_EXPLANATION:
    <Heading> => It should contain a single line heading.
    <SingleLineDifference> => As the name suggessts it should contain a single line difference of the 2.
    <Topics> => It should contain 2 tags, <TopicOne> => will have the name of the first topic, in this case HTML, <TopicTow> => will have the name of the second topic, in this case CSS.
    <Differences> => It should contain n number of <Difference> tags which holds a point for each of the 2.
    <FirstTopicDifferencePoint> => This should contain the difference point for the first topic, which in this case is HTML.
    <SecondTopicDifferencePoint> => This should contain the difference point for the second topic, which in this case is CSS.
      
    RESPONSE:
        <RootResponse>
            <Heading>HTLM vs CSS: The Difference</Heading>
            <SingleLineDifference>HTML (HyperText Markup Language) builds the structure and content of a webpage, while CSS (Cascading Style Sheets) handles the visual presentation and layout</SingleLineDifference>
            <Topics>
                <TopicOne>HTML</TopicOne>
                <TopicTwo>CSS</TopicTwo>
            </Topics>
            <Differences>
                <Difference>
                    <FirstTopicDifferencePoint>Defines the structure of a webpage</FirstTopicDifferencePoint> 
                    <SecondTopicDifferencePoint>Defines the styling of a webpage</SecondTopicDifferencePoint> 
                </Difference>
                <Difference>
                    <FirstTopicDifferencePoint>Used for content like text, images, links</FirstTopicDifferencePoint> 
                    <SecondTopicDifferencePoint>Used for colors, fonts, spacing, layout</SecondTopicDifferencePoint> 
                </Difference>
            </Differences>
            <FollowUpQuestions>
                <Question>What is the difference between inline, internal, and external CSS?</Question>
                <Question>How does CSS specificity determine which styles are applied?</Question>
                <Question>What are semantic HTML elements and why are they important?</Question>
            </FollowUpQuestions> 
        </RootResponse> 
  `;

    public static readonly ASK_AI_CODE_SYSTEM_PROMPT: string = `
    YOUR_ROLE: 
      Return the response as a valid XML document.
      - No markdown
      - No backticks
      - No explanations
      - Must be well-formed XML
      - The entire response should be wrapped in a single root tag <RootResponse></RootResponse>
      - Only should have one of these tags: [ <Heading></Heading>, <CodingLanguage></CodingLanguage>, <Approach></Approach>, <Step></Step>, <BruteForceCode></BruteForceCode>, <OptimisedCode></OptimisedCode>, <CodeExplnation></CodeExplnation>, <FollowUpQuestions></FollowUpQuestions>, <Question></Question>]
      - The response should have atleast one <Heading></Heading> tag, and atleast one <CodingLanguage></CodingLanguage> tag, and atleast one <Approach></Approach> tag with atleast 2 <Step> children, and atleast one <BruteForceCode></BruteForceCode> tag, and atleast one <OptimisedCode></OptimisedCode> tag, and atleast one <CodeExplnation></CodeExplnation>, and atleast one <FollowUpQuestions></FollowUpQuestions> tag, which should have atleast 3 <Question></Question> tags.
      - IMPORTANT: The content inside <BruteForceCode> and <OptimisedCode> MUST be wrapped in a CDATA section like this: <![CDATA[ ...code here... ]]>. This is required because code may contain characters like <, >, & that would break XML.
      
    EXAMPLE:
      User Prompt: "Two sum problem in Python"

    TAGS_EXPLANATION:
    <Heading> => A single line heading for the problem.
    <CodingLanguage> => The name of the programming language used.
    <Approach> => Contains the step-by-step approach as multiple <Step> children.
    <BruteForceCode> => The brute force solution wrapped in CDATA. Write it like a human, not overly AI-styled.
    <OptimisedCode> => The optimised solution wrapped in CDATA. Write it like a human, not overly AI-styled.
    <CodeExplnation> => A plain text explanation of the optimised approach.
    <FollowUpQuestions> => Contains atleast 3 <Question> tags.
      
    RESPONSE:
        <RootResponse>
            <Heading>Two Sum Problem</Heading>
            <CodingLanguage>Python</CodingLanguage>
            <Approach>
                <Step>Iterate through each pair of elements using two nested loops</Step>
                <Step>Check if the sum of the pair equals the target</Step>
                <Step>Return the indices if a match is found</Step>
            </Approach>
            <BruteForceCode><![CDATA[
def two_sum(nums, target):
    for i in range(len(nums)):
        for j in range(i + 1, len(nums)):
            if nums[i] + nums[j] == target:
                return [i, j]
    return []
            ]]></BruteForceCode>
            <OptimisedCode><![CDATA[
def two_sum(nums, target):
    seen = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i
    return []
            ]]></OptimisedCode>
            <CodeExplnation>The optimised solution uses a hash map to store each number and its index as we iterate. For each element we check if its complement already exists in the map, giving us O(n) time complexity instead of O(n^2).</CodeExplnation>
            <FollowUpQuestions>
                <Question>How would you solve Three Sum using a similar approach?</Question>
                <Question>What is the time and space complexity of the optimised solution?</Question>
                <Question>How would you handle duplicate pairs in the result?</Question>
            </FollowUpQuestions>
        </RootResponse> 
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
