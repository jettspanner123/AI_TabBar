# 🔍 AI Tab Bar
### Your AI-Powered Spotlight for macOS — ask anything, from anywhere.

<br/>

<p align="left">
  <img src="https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white"/>
  <img src="https://img.shields.io/badge/Swift_5.9-F05138?style=for-the-badge&logo=swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/SwiftUI-0070C9?style=for-the-badge&logo=swift&logoColor=white"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black"/>
  <img src="https://img.shields.io/badge/AppKit-0070C9?style=for-the-badge&logo=apple&logoColor=white"/>
</p>

<p align="left">
  <img src="https://img.shields.io/badge/NestJS_11-E0234E?style=for-the-badge&logo=nestjs&logoColor=white"/>
  <img src="https://img.shields.io/badge/TypeScript_5.7-3178C6?style=for-the-badge&logo=typescript&logoColor=white"/>
  <img src="https://img.shields.io/badge/Groq_API-F55036?style=for-the-badge&logo=groq&logoColor=white"/>
  <img src="https://img.shields.io/badge/Gemini_2.5-4285F4?style=for-the-badge&logo=google&logoColor=white"/>
  <img src="https://img.shields.io/badge/OpenAI_SDK-412991?style=for-the-badge&logo=openai&logoColor=white"/>
</p>

<p align="left">
  <img src="https://img.shields.io/badge/Zod_4-3E67B1?style=for-the-badge&logo=zod&logoColor=white"/>
  <img src="https://img.shields.io/badge/XML_Parser-FF6600?style=for-the-badge&logo=xml&logoColor=white"/>
  <img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white"/>
  <img src="https://img.shields.io/badge/Bun-000000?style=for-the-badge&logo=bun&logoColor=white"/>
  <img src="https://img.shields.io/badge/Multer-FF6600?style=for-the-badge&logo=npm&logoColor=white"/>
</p>

---

## 🧠 What is AI Tab Bar?

**AI Tab Bar** is a macOS menu-bar utility that brings an AI-powered Spotlight experience right to your desktop. Hit a global shortcut from **any app**, type your question, and get a structured, beautiful answer — instantly.

It supports three distinct query modes:
- 💬 **General Q&A** — ask anything, get a heading, summary, descriptive answer, and follow-up questions
- ⚖️ **Difference Mode** — compare two concepts side by side with structured difference points
- 💻 **Code Mode** — get brute force + optimised solutions with pros/cons, approach steps, and explanations

The app sits silently in the background, invisible to screen capture, and floats above all other windows.

---

## 🏗️ Project Structure

```
AI_TabBar/
├── AI_TabBar/               # macOS SwiftUI client
│   ├── Views/               # UI layer (AISpotLightSearchView + components)
│   ├── ViewModels/          # Observable view models + state observables
│   ├── Store/               # AppGlobalStateStore (single source of truth)
│   ├── Models/API/          # Codable response models
│   ├── Services/            # NetworkService (URLSession calls)
│   ├── Helpers/             # App helpers (window, env, network)
│   ├── Constants/           # App-wide constants (window sizes, icons)
│   ├── Components/          # Reusable SwiftUI components
│   └── Configurations/      # AppDelegate, window setup
│
└── Server/                  # NestJS backend
    └── src/
        ├── ai/
        │   ├── ai.controller.ts        # Route handlers
        │   ├── ai.helper.ts            # XML parsing + validation
        │   ├── ai.constants.ts         # Prompts, limits, model config
        │   ├── services/
        │   │   ├── ai.service.ts       # Business logic + retry loop
        │   │   └── ai-helper.service.ts # LLM provider calls (Groq / Gemini)
        │   └── models/
        │       ├── dto/                # Request/Response DTOs
        │       └── schemas/            # Zod + XML schemas
        └── utils/
            ├── env-validator.util.ts   # Env variable guard
            └── debug-logger.util.ts    # Request path logger
```

---

## 🔄 Data Flow

Here's how a request travels from the macOS app all the way back:

```
👆 User types query + hits Enter
        │
        ▼
📱 AISpotLightSearchViewModel
   └── calls NetworkService (URLSession POST)
        │
        ▼
🌐 NestJS Server — POST /ai/ask | /ai/code | /ai/difference
        │
        ▼
🎮 AIController
   └── validates request body (class-validator)
   └── delegates to AIService
        │
        ▼
🔁 AIService — Retry Loop (up to AI_REFETCH_LIMIT = 3 attempts)
   └── calls AIHelperService
        │
        ▼
🤖 AIHelperService
   ├── /ai/ask        → Groq (openai/gpt-oss-20b) with ASK_AI_SYSTEM_PROMPT
   ├── /ai/code       → Groq (openai/gpt-oss-20b) with ASK_AI_CODE_SYSTEM_PROMPT
   ├── /ai/difference → Groq (openai/gpt-oss-20b) with ASK_AI_DIFFERENCE_SYSTEM_PROMPT
   └── /ai/mcq        → Google Gemini 2.5 Flash (vision, structured output)
        │
        ▼
📄 Raw XML string returned from LLM
        │
        ▼
🔍 AIHelper.parseFromXML()
   └── XMLValidator validates well-formedness
   └── XMLParser parses into JS object (CDATA handled for code blocks)
   └── Zod schema validates structure
        │
        ├── ✅ Success → return parsed data immediately
        └── ❌ Failure → retry (up to 3x) → standard failure response
        │
        ▼
📦 Typed Response DTO { success, message, data }
        │
        ▼
📱 Swift decodes JSON into Codable model
        │
        ▼
🖥️ SwiftUI renders result in AISpotLightSearchView
   └── Window animates to EXPANDED state
   └── ScrollView becomes scrollable
```

---

## 🛠️ Tech Stack

### 📱 macOS Client (Swift)

| Technology | Purpose |
|---|---|
| **SwiftUI** | Declarative UI framework |
| **Swift Observation** (`@Observable`) | Reactive state management |
| **AppKit / NSWindow** | Custom borderless floating window |
| **HotKey** | Global keyboard shortcut (`Cmd + Shift + Space`) |
| **Firebase** | App configuration / analytics |
| **URLSession** | HTTP networking to the backend |
| **SwiftData** | Local persistence |

### 🖥️ Backend (NestJS)

| Technology | Purpose |
|---|---|
| **NestJS 11** | Server framework with DI, pipes, interceptors |
| **TypeScript 5.7** | Type-safe backend |
| **Groq API** | Primary LLM provider (`openai/gpt-oss-20b` via OpenAI-compatible SDK) |
| **Google Gemini 2.5 Flash** | Vision model for MCQ image analysis |
| **Vercel AI SDK** (`ai`, `@ai-sdk/google`) | Structured output generation for Gemini |
| **Instructor AI** | Function-calling structured output wrapper |
| **fast-xml-parser** | XML validation + parsing of LLM responses |
| **Zod 4** | Runtime schema validation of parsed XML |
| **Multer** | Multipart file upload handling (MCQ images) |
| **class-validator** | Request DTO validation |

---

## � Setup & Installation

### Prerequisites

- macOS **13.0+**
- **Xcode 15+**
- **Node.js 20+** or **Bun**
- A **Groq API key** — get one at [console.groq.com](https://console.groq.com)
- A **Google AI API key** — get one at [aistudio.google.com](https://aistudio.google.com)

---

### 🖥️ Server Setup

**1. Navigate to the Server directory**
```bash
cd Server
```

**2. Install dependencies**
```bash
# using npm
npm install

# or using bun
bun install
```

**3. Set up environment variables**

Create a `.env` file in the `Server/` directory:
```env
AI_TAB_BAR_GROQ_API_KEY=your_groq_api_key_here
GOOGLE_API_KEY=your_google_ai_api_key_here
PORT=3000
```

| Variable | Description |
|---|---|
| `AI_TAB_BAR_GROQ_API_KEY` | Your Groq API key for LLM calls |
| `GOOGLE_API_KEY` | Your Google AI key for Gemini (MCQ vision) |
| `PORT` | Server port (defaults to `3000`) |

**4. Start the server**
```bash
# development (with hot reload)
npm run start:dev

# production build
npm run build
npm run start:prod
```

The server will be running at `http://localhost:3000` 🎉

---

### 📱 macOS App Setup

**1. Open the Xcode project**
```bash
open AI_TabBar.xcodeproj
```

**2. Add your `GoogleService-Info.plist`**

Place your Firebase `GoogleService-Info.plist` inside `AI_TabBar/` (already in the project structure, replace with your own).

**3. Resolve Swift Package dependencies**

Xcode will automatically resolve packages on first open. If not:
`File → Packages → Resolve Package Versions`

**4. Configure the server URL**

In `AI_TabBar/Constants/NetworkServiceConstants.swift`, make sure the base URL points to your running server:
```swift
// e.g. http://localhost:3000
```

**5. Build & Run**

Select your Mac as the target and hit `Cmd + R`. The app runs as a menu-bar accessory — no Dock icon.

**6. Trigger the spotlight**

Press **`Cmd + Shift + Space`** from anywhere to open the AI search bar.

---

## ⚙️ Key Configuration

| Constant | Value | Description |
|---|---|---|
| `AI_REFETCH_LIMIT` | `3` | Max retry attempts per endpoint on XML/Zod failure |
| `AI_MODEL` | `gemini-2.5-flash` | Gemini model used for MCQ vision |
| `WINDOW_DIMENTIONS_COLLAPSED` | `900 × 120` | Search bar height when idle |
| `WINDOW_DIMENTIONS_EXPANDED` | `900 × 800` | Window height when results are shown |
| `SEARCH_AREA_TOP_OFFSET` | `200` | Distance from top of screen |
| `MCQ_IMAGE_MAX_FILE_SIZE_BYTES` | `5MB` | Max image size for MCQ endpoint |

---

## 🤝 Contributing

Contributions are welcome!

```bash
git clone https://github.com/jettspanner123/AI_TabBar
cd AI_TabBar
git checkout -b feature/your-feature-name
```

Then open a PR and describe what you've built. 🚀

---

## 📄 License

This project is **UNLICENSED** — private use only.
