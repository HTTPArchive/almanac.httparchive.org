---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Generative AI
description: Generative AI chapter of the 2025 Web Almanac covering the transition to local browser-based AI, the adoption of WebNN and Built-in AI, new discoverability standards like llms.txt, and the emergence of AI fingerprints on the web.
hero_alt: Hero image illustrating an AI-assisted web development workflow. Source code and image assets, marked with stars to indicate AI generation, flow into a pipeline where a red character feeds tokens and a blue brain-like character oversees the process, resulting in a fully rendered web page displayed in a browser window.
authors: [christianliebel, Yash-Vekaria, JonathanPagel]
reviewers: [tomayac, umariqbal, webmaxru]
analysts: [JonathanPagel, christianliebel, tomayac]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1q_hFsWlt6DZMmwnxrTmU3nCRjT2w38AomAlw8b_lthE/edit
christianliebel_bio: Christian Liebel, M.Sc., is an elected member of the <a hreflang="en" href="https://w3ctag.org/">W3C Technical Architecture Group</a> (TAG), a participant in the <a hreflang="en" href="https://webmachinelearning.github.io/">W3C Web Machine Learning</a> (WebML) Community and Working Groups, and a Google Developer Expert (GDE) for Web AI.
Yash-Vekaria_bio: Yash Vekaria is a PhD candidate in Computer Science at <a hreflang="en" href="https://www.ucdavis.edu/">University of California, Davis</a>. He carries out web-based large-scale internet measurements to study and improve the dynamics of web. Specifically, his research is focused at studying and bringing transparency to online tracking practices and user privacy issues.
JonathanPagel_bio: Jonathan Pagel studied e-commerce in his bachelor's degree and has since been interested in the field, particularly in the areas of speed optimization and accessibility for shops and websites. Currently, he is freelancing in this field and pursuing a Master's in AI and Society.
featured_quote: In 2025, Generative AI transitioned from a cloud-only technology to a fundamental browser component.
featured_stat_1: 591%
featured_stat_label_1: Increase in WebGPU adoption
featured_stat_2: 340%
featured_stat_label_2: Increase in WebLLM npm downloads
featured_stat_3: 4.5%
featured_stat_label_3: Websites defining `robots.txt` rules for OpenAI's GPTBot
---

## Introduction

On November 30, 2022, <a hreflang="en" href="https://openai.com/index/chatgpt/">OpenAI launched ChatGPT</a>, a service that catapulted _Generative Artificial Intelligence_ (Generative AI) from research labs <a hreflang="en" href="https://openai.com/index/how-people-are-using-chatgpt/#:~:text=Given%20the%20sample%20size%20and%20700%20million%20weekly%20active%20users%20of%20ChatGPT">into the daily lives of millions</a>. This launch fundamentally changed user expectations regarding how applications and the web should function. Furthermore, the accompanying _Application Programming Interface_ (API) gave software developers a powerful tool to make their applications significantly smarter.

{{ figure_markup(
  content="700,000,000",
  caption="Weekly active users of ChatGPT.",
  classes="big-number",
) }}

Generative AI is a specialized field that focuses on processing and generating human-understandable content, including text, source code, images, videos, speech, and music. _Large Language Models_ (LLMs) represent a significant component of this field. Trained on vast amounts of textual data, LLMs interpret and generate natural language, expanding software architecture by enabling developers to process human language effectively for the first time. Recently, Generative AI features have been integrated into established applications, including Windows, Office, and Photoshop.

As Generative AI becomes increasingly widespread, this chapter examines its emerging trends on the web. Specifically, it focuses on the use of local Generative AI, enabled by "Built-in AI" and "Bring Your Own AI" approaches, the discoverability of Generative AI content via `llms.txt`, and the impact of Generative AI on content creation and source code (_AI fingerprints_).

## Data sources

This chapter uses not only the dataset of HTTP Archive, but also <a hreflang="en" href="https://www.npmjs.com/">npm</a> download statistics, and data provided by <a hreflang="en" href="https://chromestatus.com/">Chrome Platform Status</a> and other researchers.

Unless otherwise noted, we refer to the July 2025 crawl of the HTTP Archive, as described in [Methodology](./methodology). For detecting API adoption, we scanned websites for the presence of the specific API calls in code. Note that this only indicates their occurrence, but not necessarily actual usage during runtime. Usage data from Chrome Platform Status always refers to the percentage of Google Chrome page loads that use a certain API at least once, across all release channels and platforms.

## Technology overview

In this section, we will explain the difference between cloud-based and local AI models, discuss the pros and cons of these approaches, and then examine local technologies in detail.

### Cloud versus local

Most people use Generative AI through cloud services such as <a hreflang="en" href="https://openai.com/api/">OpenAI</a>, <a hreflang="en" href="https://ai.azure.com/">Microsoft Foundry</a>, <a hreflang="en" href="https://aws.amazon.com/de/bedrock/">AWS Bedrock</a>, <a hreflang="en" href="https://cloud.google.com/products/ai">Google Cloud AI</a>, or the <a hreflang="en" href="https://platform.deepseek.com/">DeepSeek Platform</a>. Because these providers have access to immense computational resources and storage capacity, they offer several key advantages:

- **High-quality responses**: The models are extremely capable and powerful.
- **Fast inference times**: Responses are generated quickly on powerful servers.
- **Minimal data transfer**: Only input and output data need to be transmitted, not the entire AI model.
- **Hardware independence**: It works regardless of the client's hardware and computing resources.

However, cloud-based models also have their drawbacks:

- **Connectivity**: They require a stable internet connection.
- **Reliability**: They are subject to network latency, server availability, and capacity limits.
- **Privacy**: Data must be transferred to the cloud service, which raises potential privacy concerns. It is often unclear if user data is being used to train future model iterations.
- **Cost**: They usually require a subscription or API usage fees, so website authors often have to pay for the inference.

### Local AI technologies

The limitations of cloud-based systems can be addressed by migrating inference to the client via local AI technologies, [referred to as Web AI](https://developer.chrome.com/blog/io24-web-ai-wrapup#:~:text=Web%20AI%20is%20a%20set%20of%20technologies%20and%20techniques%20to%20use%20machine%20learning%20\(ML\)%20models%2C%20client%2Dside%20in%20a%20web%20browser%20running%20on%20a%20device%27s%20CPU%20or%20GPU.). Since models are downloaded to the user's system, their _weights_ (internal model parameters) cannot be kept a secret. As a result, this approach is mostly used in combination with open-weight models, which are <a hreflang="en" href="https://www.vellum.ai/llm-leaderboard">typically less powerful</a> than their commercial, cloud-based, closed-weight counterparts. <a hreflang="en" href="https://epoch.ai/data-insights/open-weights-vs-closed-weights-models">According to Epoch AI</a>, open-weight models lag behind state-of-the-art by around three months on average.

{{ figure_markup(
  content="3 months",
  caption="The average lag of open-weight models behind state-of-the-art performance.",
  classes="big-number",
) }}

The <a hreflang="en" href="https://webmachinelearning.github.io/">Web Machine Learning</a> Community Group and Working Group of the <a hreflang="en" href="https://www.w3.org/">World Wide Web Consortium</a> (W3C) are actively standardizing this shift to make AI a "first-class web citizen." This effort follows two primary architectural directions: _Bring Your Own AI_ and _Built-in AI_.

#### Bring Your Own AI

In the Bring Your Own AI (BYOAI) approach, the developer is responsible for shipping the model to the user. The web application downloads a specific model binary and executes it using low-level APIs on local hardware. This allows running highly specialized models, tailored to the use case, but also requires significant bandwidth.

There are <a hreflang="en" href="https://www.w3.org/2024/01/webevolve-series-events/media/slides/hu-ningxin.pdf#page=4">three processing units</a> that can be used to run AI inference locally:

- _Central Processing Unit_ (CPU): Responds quickly, ideal for low-latency AI workloads.
- _Graphics Processing Unit_ (GPU): High throughput, ideal for AI-accelerated digital content creation.
- _Neural Processing Unit_ (NPU) or _Tensor Processing Unit_ (TPU): Low power, ideal for sustained AI workloads and AI offload for battery life.

The three key APIs that facilitate local AI inference are WebAssembly (CPU), WebGPU (GPU), and WebNN (CPU, GPU, and NPU).

It is essential to note that the use of WebAssembly and WebGPU does not confirm AI activity; these are general-purpose APIs frequently utilized for tasks such as complex calculations, 3D visualizations, or gaming.

##### WebAssembly

[WebAssembly](https://developer.mozilla.org/docs/WebAssembly) acts as the bytecode for the web. Code written in various programming languages, including C++ and Rust, can be compiled into WebAssembly. It enables developers to write optimized, high-performance code that is executed by the browser's scripting engine on the user's CPU.

WebAssembly has broad browser support, being implemented in all relevant browser engines since 2017.

{{ figure_markup(
  image="genai-wasm-usage.png",
  caption="WebAssembly usage in 2025 according to Chrome Platform Status data.",
  description="Line chart showing the growth of WebAssembly usage in percent per page loads according to Chrome Platform Status data throughout 2025. Usage increased linearly from being active on 4.44% of page loads in January to 5.64% in December.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=148205691&format=interactive",
  sheets_gid="303424003"
  )
}}

According to <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2237">Chrome Platform Status data</a>, the usage of WebAssembly experienced 27% linear growth from being active on 4.44% of page loads in January 2025, and 5.64% in December 2025. In January 2024, WebAssembly was only active during 3.37% of page loads.

##### WebGPU

[WebGPU](https://developer.mozilla.org/docs/Web/API/WebGPU_API) is the modern successor to [WebGL](https://developer.mozilla.org/docs/Web/API/WebGL_API), designed to expose the capabilities of modern GPUs to the web. Unlike WebGL, which was strictly for graphics, WebGPU provides support for _compute shaders_, allowing for general-purpose computing on graphics cards. This allows developers to perform massive parallel calculations, as required by AI models, directly on the user's graphics card.

WebGPU has become the standard foundation for running AI workloads in the browser. With the release of Firefox 141 in November 2025, [WebGPU became available in all relevant browser engines](https://web.dev/blog/webgpu-supported-major-browsers) (Chromium, Gecko, and WebKit).

{{ figure_markup(
  image="genai-webgpu-usage.png",
  caption="WebGPU usage in 2025.",
  description="Bar chart comparing the usage of WebGPU (percentage of pages) from the July 2024 crawl to the July 2025 crawl. On desktop, usage increased from 0.035% to 0.243%. On mobile, usage increased from 0.029% to 0.238%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=2117448035&format=interactive",
  sheets_gid="1071092495"
  )
}}

The July 2025 crawl of HTTP Archive data shows that the API is used on 0.243% of all desktop sites and 0.238% of mobile sites. While still small overall, this represents a significant increase of 591% (up from 0.035%) on desktop and 709% (up from 0.029%) on mobile compared to the July 2024 crawl. <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/3888">Chrome Platform Status data</a> suggests an exponential growth in activations per page load, increasing by 147% over the course of 2025.

##### WebNN

The <a hreflang="en" href="https://webnn.io/en">Web Neural Network API</a> (WebNN) is a dedicated API specifically for machine learning. Specified by the WebML Working Group, this API is on the W3C Recommendation track—the formal process for becoming a web standard.

WebNN serves as a hardware-agnostic abstraction layer, allowing the browser to route operations to the most efficient hardware available on the device. In contrast to WebAssembly (CPU-only) and WebGPU (GPU-only), WebNN can perform computations on the CPU, GPU, and NPU. It can achieve near-native execution speeds.

{{ figure_markup(
  image="genai-webnn-usage.png",
  caption="WebNN usage in 2025 according to Chrome Platform Status data.",
  description="Line chart showing the WebNN usage in percent per page loads according to Chrome Platform Status data throughout 2025. Adoption is extremely low and fluctuates, peaking at only 0.000029% of page loads in February, but also reaching 0% of page loads in May and July.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=2004233407&format=interactive",
  sheets_gid="939568069"
  )
}}

WebNN is in active development and is currently implemented behind a flag <a hreflang="en" href="https://webnn.io/en/api-reference/browser-compatibility/api">in Chromium-based browsers</a> on ChromeOS, Linux, macOS, Windows, and Android. In November 2025, <a hreflang="en" href="https://github.com/mozilla/standards-positions/issues/1215#issuecomment-3520278819">Firefox joined as the second engine formally supporting the API</a>. Given that WebNN is still an experimental API, the usage count is currently very low, with high fluctuation and a maximum activation rate of 0.000029% in February 2025 according to <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/5023">Chrome Platform Status data</a>.

##### Runtimes: ONNX Runtime and Tensorflow.js

<a hreflang="en" href="https://onnxruntime.ai/docs/tutorials/web/">ONNX Runtime</a> (developed by Microsoft) and <a hreflang="en" href="https://www.tensorflow.org/js">Tensorflow.js</a> (developed by Google) are two of the leading runtimes for executing AI models directly in the browser. These runtimes abstract away the complexities of low-level technologies like WebAssembly, WebGPU, and WebNN.

TensorFlow.js is tightly integrated with the TensorFlow ecosystem and supports both training and inference, while ONNX Runtime focuses on cross-platform inference using the ONNX standard, enabling models from multiple frameworks to run client-side.

{{ figure_markup(
  image="genai-runtime-downloads.png",
  caption="npm package downloads of `@tensorflow/tfjs` and `onnxruntime-web`.",
  description="Line chart comparing the npm package download numbers of the AI runtimes ONNX Runtime and Tensorflow.js from January to November 2025. ONNX Runtime downloads grew rapidly from 773,018 downloads in January to 2,204,245 in November, while Tensorflow.js only grew from 509,599 to 869,680 downloads in the same period.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=2128444354&format=interactive",
  sheets_gid="815003361"
  )
}}

From January to November 2025, <a hreflang="en" href="https://npm-stat.com/charts.html?package=onnxruntime-web&from=2025-01-01&to=2025-11-30">npm package downloads of ONNX Runtime</a> increased by 185%, while <a hreflang="en" href="https://npm-stat.com/charts.html?package=%40tensorflow%2Ftfjs&from=2025-01-01&to=2025-11-30">TensorFlow.js's downloads</a> increased by 70%, demonstrating strong and growing developer interest in browser-based AI.

##### Libraries: WebLLM and Transformers.js

<a hreflang="en" href="https://webllm.mlc.ai/">WebLLM</a>, developed by the <a hreflang="en" href="https://mlc.ai/">MLC AI</a> research team, is a high‑performance in‑browser inference engine specialized for LLMs. It allows running various open-weight LLMs, including <a hreflang="en" href="https://www.llama.com/">Llama</a>, <a hreflang="en" href="https://azure.microsoft.com/en-us/products/phi">Phi</a>, <a hreflang="en" href="https://deepmind.google/models/gemma/">Gemma</a>, or <a hreflang="en" href="https://mistral.ai/">Mistral</a>, directly in the browser. Currently, WebLLM uses WebGPU for inference.

{{ figure_markup(
  image="genai-webllm-downloads.png",
  caption="npm package downloads of `@mlc-ai/web-llm`.",
  description="Line chart showing npm downloads for the `@mlc-ai/web-llm` package from January to November 2025. Downloads increased by 340% from 23,425 package downloads in January to 103,084 downloads in November, with a significant spike occurring in August where downloads nearly doubled from 57,114 in July to 102,440 in August.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=672596885&format=interactive",
  sheets_gid="87936740"
  )
}}

WebLLM has quickly become one of the most prominent solutions for in‑browser LLM inference. Between January and November 2025, <a hreflang="en" href="https://npm-stat.com/charts.html?package=%40mlc-ai%2Fweb-llm&from=2025-01-01&to=2025-11-30">WebLLM package downloads from npm</a> increased by 340%. In August alone, the downloads numbers nearly doubled. We were unable to attribute this surge to a specific event.

<a hreflang="en" href="https://huggingface.co/docs/transformers.js/index">Transformers.js</a>, developed by <a hreflang="en" href="https://huggingface.co/">Hugging Face</a>, functions as a comprehensive JavaScript library that mirrors the popular Python `transformers` API. Under the hood, it relies on ONNX Runtime to execute. It allows developers to run pre-trained models for various tasks through simple high-level pipelines, not just LLMs.

{{ figure_markup(
  image="genai-tfjs-downloads.png",
  caption="npm package downloads of `@huggingface/transformers.`",
  description="Line chart showing npm downloads for the `@huggingface/transformers` package from January to November 2025. Downloads nearly tripled from 240,389 in January to 719,103 in November. The trend highlights a significant spike in August, reaching a year-to-date peak of 758,393.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1045307255&format=interactive",
  sheets_gid="303133226"
  )
}}

From January to November 2025, the <a hreflang="en" href="https://npm-stat.com/charts.html?package=%40huggingface%2Ftransformers&from=2025-01-01&to=2025-11-30">npm package downloads</a> almost tripled, also with a notable surge in August 2025.

#### Built-in AI

[Built-in AI](https://developer.chrome.com/docs/ai/built-in) is an initiative by Google and Microsoft that aims to provide high-level AI APIs to web developers. Unlike BYOAI, this approach leverages models facilitated by the browser itself. While developers cannot specify an exact model, this method allows all websites to share the same model, meaning it only needs to be downloaded once.

The initiative consists of multiple APIs:

- **Prompt API**: Gives developers low-level access to a local LLM.
- Task-specific APIs:
  - **Writing Assistance APIs**: Summarizing, writing, and rewriting text.
  - **Proofreader API**: Finding and fixing mistakes in text.
  - **Language Detector** and **Translator APIs**: Detecting the language of text content and translating it into another language.

All APIs are specified within the WebML Community Group, meaning they are still incubating, and are not yet on the W3C Recommendation track. Some of the APIs are already generally available, while [others need a browser flag to be enabled](https://developer.chrome.com/docs/ai/built-in-apis) or are in [Origin Trial](https://developer.chrome.com/docs/web-platform/origin-trials), requiring a registered token for activation—unlike WebGPU, which is now stable and widely available for shipping production features.

{{ figure_markup(
  image="genai-typings-downloads.png",
  caption="npm package downloads of `@types/dom-chromium-ai`.",
  description="Line chart showing npm downloads for the `@types/dom-chromium-ai` package from January to November 2025. Downloads started at 2,653 in January, peaked at 25,770 in August, and followed a gradual decline to 12,478 in November.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=83152267&format=interactive",
  sheets_gid="232169116"
  )
}}

<a hreflang="en" href="https://npm-stat.com/charts.html?package=%40types%2Fdom-chromium-ai&from=2025-01-01&to=2025-11-30">The download numbers</a> of the <a hreflang="en" href="https://www.npmjs.com/package/@types/dom-chromium-ai">`@types/dom-chromium-ai` package</a>, containing TypeScript typings for Built-in AI, may reflect the experimental status of the APIs: Downloads peaked in August 2025 with 25,770 downloads, followed by a gradual decline. This trend may suggest that developers are hesitant to adopt experimental APIs. However, the download statistics for a typings package may not reflect the actual usage of the API.

##### Prompt API

The Prompt API introduces a standardized interface for accessing LLMs facilitated by the user's browser, such as <a hreflang="en" href="https://store.google.com/intl/en/ideas/articles/gemini-nano-offline/">Gemini Nano</a> in Chrome or <a hreflang="en" href="https://learn.microsoft.com/en-us/microsoft-edge/web-platform/prompt-api">Phi-4-mini</a> in Edge. By leveraging these one-time-download models, the API eliminates the bandwidth barriers and cold-start latency associated with libraries that require downloading model weights.

However, as of December 2025, the technology remains in a transitional phase: it has [fully shipped for browser extensions in Chrome 138](https://developer.chrome.com/docs/ai/prompt-api), but web page access is still restricted to an Origin Trial. The API is not currently available on mobile devices.

{{ figure_markup(
  image="genai-prompt-api-adoption.png",
  caption="Prompt API adoption.",
  description="Bar chart comparing the adoption of the Prompt API on desktop and mobile sites during the July 2025 crawl. The API was detected on 0.095% of all desktop sites and 0.078% of all mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1191364409&format=interactive",
  sheets_gid="1142091854",
  sql_file="../capabilities/fugu.sql"
  )
}}

Consequently, adoption remains nascent; HTTP Archive data from July 2025 (the first measurement available) detected the API on just 0.095% of all desktop sites and 0.078% of all mobile sites, reflecting its current status as an experiment rather than a standard utility.

Most of the example sites we analyzed used the Prompt API through an external script, [Google Publisher Tags](https://developers.google.com/publisher-tag/guides/get-started). This project enables authors to incorporate dynamic advertisements into their websites. The <a hreflang="en" href="https://securepubads.g.doubleclick.net/pagead/managed/js/gpt/m202512040101/pubads_impl.js">Google Publisher Tags script</a> uses the Prompt API to categorize the page's content into a list of the <a hreflang="en" href="https://github.com/InteractiveAdvertisingBureau/Taxonomies/blob/develop/Content%20Taxonomies/Content%20Taxonomy%203.1.tsv">Interactive Advertising Bureau (IAB) Content Taxonomy 3.1 categories</a>, and the Summarizer API (see next section) to generate a summary of the page's content, and sends both to the server. However, the code branch didn't seem to be active during our analysis.

##### Writing Assistance APIs and Proofreader API

Next, we examine the task-specific APIs. The <a hreflang="en" href="https://learn.microsoft.com/en-us/microsoft-edge/web-platform/writing-assistance-apis">Writing Assistance APIs</a> abstract the complexities of prompt engineering; they utilize the same underlying embedded LLM but apply specialized system prompts to achieve distinct linguistic goals:

- **Writer API**: creates new content based on a prompt
- **Rewriter API**: rephrases input based on a prompt
- **Summarizer API**: produces a summary of text

Additionally, the [Proofreader API](https://developer.chrome.com/docs/ai/proofreader-api) enables developers to proofread text and correct grammatical errors and spelling mistakes.

The Summarizer API shipped with Chrome 138. As of December 2025, the Writer, Rewriter, and Proofreader API are in Origin Trial. All APIs are not currently available on mobile devices.

In the July 2025 HTTP Archive crawl, only calls to `Writer.create()` were detected (on 0.127% desktop and 0.137% mobile sites). While this initially suggested usage of the Writer API, manual checks revealed that many sampled sites were actually using <a hreflang="en" href="https://github.com/protobufjs/protobuf.js/blob/827ff8e48253e9041f19ac81168aa046dbdfb041/src/writer.js#L142">Protobuf.js's Writer</a>, which shares the same API signature. As a result, we have decided to omit the chart for this metric.

##### Translator and Language Detector APIs

The final category of the Built-in AI APIs consists of the [Translator and Language Detector APIs](https://developer.mozilla.org/docs/Web/API/Translator_and_Language_Detector_APIs). Unlike the Writing Assistance APIs, these APIs do not rely on LLMs, but instead utilize specialized, task-specific neural networks, placing them outside the strict definition of Generative AI.

[The APIs shipped in Chrome 138](https://developer.chrome.com/release-notes/138#web_apis) but are not currently available on mobile devices.

{{ figure_markup(
  image="genai-translator-language-detector-adoption.png",
  caption="Translator and Language Detector API adoption.",
  description="Bar chart comparing the adoption of the Translator and Language Detector APIs on desktop and mobile sites during the July 2025 crawl. The adoption rates are nearly identical: the Translator API was found on 0.277% of desktop and 0.262% of mobile sites, while the Language Detector API appeared on 0.276% of desktop and 0.261% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=463876937&format=interactive",
  sheets_gid="1189045533",
  sql_file="../capabilities/fugu.sql"
  )
}}

They have achieved the widest adoption of the Built-in AI APIs. The July 2025 HTTP Archive crawl detected the Translator API on 0.277% of all desktop sites and 0.262% of all mobile sites, with the Language Detector API used on just 0.001% fewer sites.

Many of the sample sites we checked utilized the review tool <a hreflang="en" href="http://Judge.me">Judge.me</a>, which serves as an add-on for Shopify stores. Judge.me <a hreflang="en" href="https://judge.me/help/en/articles/11379816-translating-reviews-in-the-review-widget">utilizes both the Language Detector and Translator APIs</a>, which may be the reason for the tight coupling of usage: The Language Detector API was present on nearly the same absolute number of sites, trailing the Translator API by only approximately 100 sites.

#### Browser-specific runtimes: Firefox AI Runtime

As an alternative to the Built-in AI APIs proposed by the Chromium side, Firefox experiments with the <a hreflang="en" href="https://firefox-source-docs.mozilla.org/toolkit/components/ml/index.html">Firefox AI Runtime</a>, a local inference runtime based on Transformers.js and the ONNX Runtime, which runs natively. However, the runtime is not yet accessible from the public web. It can only be used by extensions and other privileged uses, such as the <a hreflang="en" href="https://www.firefox.com/en-US/features/translate/">built-in translation feature</a> of Firefox.

## Discoverability

In this section, we look at the dynamics of web discoverability with increasing adoption of Generative AI on the web. We primarily focus on two important approaches that influence how AI platforms and services discover content: the `robots.txt` and `llms.txt` files.

### `robots.txt`

The <a hreflang="en" href="https://www.robotstxt.org/">`robots.txt` file</a>, located at the root of a domain (for example, `http://example.com/robots.txt`), allows website owners to declare crawl directives for automated bots. Historically, web crawling was primarily performed by search engines and archives. However, in the age of Generative AI, websites can also be crawled by AI agents, or by model providers collecting internet-scale data to train their LLMs. Consequently, websites increasingly rely on `robots.txt` files to manage access for these crawlers.

An example directive targeting the user agent `GPTBot`, <a hreflang="en" href="https://platform.openai.com/docs/bots">used by OpenAI for model training</a>, is shown below:

```
User-Agent: GPTBot
Disallow: /
```

It is important to note that adherence to `robots.txt` is voluntary and does not strictly enforce access control.

{{ figure_markup(
  image="genai-robots-txt-adoption.png",
  caption="`robots.txt` adoption.",
  description="Bar chart comparing sites with and without `robots.txt`. A significant 94.1% of sites serve the file.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1609639660&format=interactive",
  sheets_gid="342591090",
  sql_file="sites-with-robot-txt.sql"
  )
}}

Usage of `robots.txt` remains highly prevalent: approximately 94.1% of the ~12.9 million sites analyzed include a `robots.txt` file with at least one directive.

{{ figure_markup(
  image="genai-robots-txt-directives.png",
  caption="Top `robots.txt` directives by website ranks.",
  description="Bar chart ranking the most common `robots.txt` User-Agent directives by site rank. The wildcard `*` is the most common directive, followed by the `gptbot` directive. The next AI bot, `claudebot`, is on eighth position. Top 1k sites tend to mention bots more often than less popular sites. For example, `gptbot` is mentioned in the `robots.txt` file of 20.9% of top 1k sites, 12.1% of top 10k sites, 6.1% of top 100k sites, 3.6% of top 1 million sites, and 4% of top 10 million sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1897808878&format=interactive",
  width="621",
  height="845",
  sheets_gid="342591090",
  sql_file="user-agent-named.sql"
  )
}}

The figure above shows the top directives observed across all websites, grouped by their rank. The wildcard directive `*` is the most commonly used one, present in 97.4% of `robots.txt` files. It allows site authors to set global rules for all bots. The second most used user agent is `gptbot` (note, our analysis lower-cased the user-agent names), which saw adoption rise [from 2.6% in 2024](../2024/seo#ai-crawlers) to [around 4.5% in 2025](../2025/seo#ai-crawlers-named-in-robotstxt).

Other frequently targeted AI bots include those from <a hreflang="en" href="https://www.anthropic.com/">Anthropic</a> (`claudebot`, `anthropic-ai`, `claude-web`), Google (`google-extended`), OpenAI (`chatgpt-user`), and <a hreflang="en" href="https://www.perplexity.ai/">Perplexity</a> (`perplexitybot`).

Directives targeting AI bots are significantly more common on popular websites, with nearly all of them disallowing access. This is likely because popular websites can restrict AI crawlers without negatively impacting their organic traffic. Overall, we observed a clear increase in the adoption of AI-specific directives within `robots.txt` files.

### `llms.txt`

The <a hreflang="en" href="https://llmstxt.org/">`llms.txt` file</a> is an emerging proposal designed to help LLMs effectively utilize a website at inference time. Similar to `robots.txt`, it is hosted at the root of a website's domain (for example, `https://example.com/llms.txt`). The key distinction lies in their function: while `robots.txt` instructs bots as to what they are allowed or disallowed to crawl during training or inference, `llms.txt` provides a structured, LLM-friendly overview of the website's content. This allows LLMs to efficiently navigate through a website in real-time when answering user queries.

{{ figure_markup(
  image="genai-llms-txt-adoption.png",
  caption="`llms.txt` adoption.",
  description="Bar chart comparing desktop and mobile sites with and without `llms.txt`. The file is only present on 2.13% of desktop and 2.1% of mobile sites, and absent on the vast majority of 97.87% desktop and 97.9% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1543827839&format=interactive",
  sheets_gid="187293662"
  )
}}

As `llms.txt` is relatively new, we observed very limited usage on the web. Across desktop pages, only 2.13% exhibit valid `llms.txt` entries, while 97.87% show no evidence of this file. Mobile pages showed a similar pattern, with 2.1% of pages containing valid entries and 97.9% lacking them.

The overwhelming majority of sites therefore do not yet articulate explicit AI access preferences via `llms.txt`. Where present, the file indicates that early adopters are likely experimenting with AI-driven discoverability, facilitating agentic use cases, or exploring _Generative Engine Optimization_ (GEO). In contrast to Search Engine Optimization (SEO), GEO focuses on making content easily ingestible by LLMs or AI-enabled search tools like Perplexity or <a hreflang="en" href="https://search.google/ways-to-search/ai-mode/">Google AI Mode</a>. For more information see the [SEO](/seo#llmstxt) chapter.

## AI fingerprints

Services such as <a hreflang="en" href="https://chatgpt.com/">OpenAI ChatGPT</a>, <a hreflang="en" href="https://gemini.google.com/">Google Gemini</a>, and <a hreflang="en" href="https://www.copilot.com/">Microsoft Copilot</a> are already widely used. Increasingly, content is being written with the assistance of AI. This section analyzes the impact of Generative AI on web content and source code.

### AI colors

Models can tend to overrepresent certain words, which then serve as an AI fingerprint. Researchers at Florida State University compared research papers published on PubMed between 2020 and 2024. <a hreflang="en" href="https://aclanthology.org/2025.coling-main.426.pdf">Their analysis</a> revealed a staggering 6,697% increase in the use of the word "delves." The other conjugations of the verb "delve" also increased significantly. While those kinds of indicators should never be used to classify individual cases as AI-generated, they are still useful for understanding the trend of adoption. In this part of the chapter, we will delve into ;) common patterns used by LLMs to generate websites.

{{ figure_markup(
  content="6,697%",
  caption="Usage increase of the word \"delves\" in research papers published on PubMed.",
  classes="big-number",
) }}

The most recognizable indicator of AI-generated web design is the pervasive use of purple and gradients, often referred to as "<a hreflang="en" href="https://ai-engineering-trend.medium.com/the-mystery-behind-ais-purple-problem-revealed-0234afdb292e">the AI Purple Problem</a>."

[Adam Wathan](https://x.com/adamwathan), creator of the widely adopted CSS framework <a hreflang="en" href="https://tailwindcss.com/">Tailwind</a>, noted <a hreflang="en" href="https://youtu.be/AG_791Y-vs4?t=86">in a recent interview</a> that this trend likely stems from the timing of major AI training crawls. In the early 2020s, the Tailwind team used deep purples extensively in their documentation and examples to reflect contemporary design trends. Consequently, LLMs trained on that data seem to have "locked in" an aesthetic that has since been replaced by more modern trends, such as the current preference for black designs.

To quantify the "AI Purple" aesthetic, we analyzed the CSS (responsible for website styling) of all root pages in our dataset from the years following the release of ChatGPT. We tracked the presence of the well-known `indigo-500` color (`#6366f1`), the use of CSS gradients, and other colors associated with AI-generated websites.

{{ figure_markup(
  image="genai-ai-colors-tailwind.png",
  caption="Usage of \"AI colors\" over the years in Tailwind pages.",
  description="Line chart comparing the usage of the aforementioned AI colors and indigo-500 on Tailwind pages, based on quarterly HTTP Archive crawls since Q3 2022. Both lines follow a similar pattern, with usage rates fluctuating around 2% of Tailwind pages. There is no noticeable surge in the usage of either color.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1045089879&format=interactive",
  width="642",
  height="417",
  sheets_gid="1065437374",
  sql_file="gradient.sql"
  )
}}

Because Tailwind is the preferred framework for LLMs like Claude, Gemini, and the OpenAI models, we specifically examined the percentage of Tailwind-based websites using these indicators. Tailwind web pages were identified using a <a hreflang="en" href="https://github.com/HTTPArchive/wappalyzer">Wappalyzer fork</a> from the HTTP Archive. Surprisingly, there was no noticeable surge in websites using either `indigo-500` or the other two commonly mentioned AI colors (`#8b5cf6` violet and `#a855f7` purple).

{{ figure_markup(
  image="genai-ai-colors.png",
  caption="Usage of \"AI colors\" over the years.",
  description="Line chart comparing the use of the aforementioned AI colors and indigo-500 across all pages, based on quarterly HTTP Archive crawls since Q3 2022. Their use rose from 0.02% (purple) and 0.03% (indigo-500) in Q3 2022 to 0.49% (purple) and 0.54% (indigo-500) in Q4 2025, with indigo-500 becoming slightly more popular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=428756366&format=interactive",
  width="642",
  height="417",
  sheets_gid="1065437374",
  sql_file="gradient.sql"
  )
}}

However, due to the explosive overall growth of the Tailwind framework, these specific colors saw a significant rise when measured as a percentage of the entire web.

Our analysis relied solely on CSS variables, as parsing the entire source code would exceed practical limits. As a result, our figures represent a conservative estimate. Sites using hardcoded hex values (for example, `#6366f1`) or older preprocessors were invisible to our queries. Additionally, even a 1% adjustment to a color's lightness would cause it to evade our detection.

Despite the frequent online discourse regarding ["AI slop"](https://www.wikipedia.org/wiki/AI_slop) and purple-tinted designs, our analysis of the HTTP Archive dataset suggested that this trend may be less a result of AI "choosing" purple and more a reflection of the general rise in Tailwind's popularity.

We also tested for surges in gradients, shadows, and specific fonts, but found no statistically significant increases.

### Vibe coding platforms

One of the reasons for the large number of newly created websites is the emergence of platforms that make building them easier. After the spread of Content Management System (CMS) tools in the previous decade, users can now move beyond those guardrails and use tools like <a hreflang="en" href="https://v0.app/">v0</a>, <a hreflang="en" href="https://replit.com/">Replit</a>, or <a hreflang="en" href="https://lovable.dev/">Lovable</a> to generate websites through conversational AI. These platforms allow users to publish pages using their own domains or a platform-provided subdomain (for example, `mywebsite.tool.com`).

{{ figure_markup(
  image="genai-vibe-coding-subdomains.png",
  caption="Subdomains of vibe coding platforms.",
  description="Line chart comparing the count of vibe coding platform subdomains relative to the entire HTTP Archive dataset, based on quarterly crawls since Q1 2020. Vercel leads the trend, rising steadily from 2021 to reach nearly 0.04% of all sites by October 2025, while newer entrants like Lovable and Replit show visible adoption beginning in early 2025.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1670163713&format=interactive",
  width="797",
  height="417",
  sheets_gid="2051033428",
  sql_file="vibecodetools.sql"
  )
}}

The chart above illustrates the relative growth of vibe coding platform subdomains within the HTTP Archive dataset. While Vercel (`*.vercel.app`) remains the dominant provider, it has offered subdomain hosting long before the release of its vibe coding tool v0 (`*.v0.dev`) in late 2023. The data showed no immediate surge following the launch of v0. Lovable (`*.lovable.app` and `*.lovable.dev`) grew from only 10 subdomains at the beginning of 2025 to 315 by October 2025. Please note that this only includes pages available in the dataset. According to Lovable, <a hreflang="en" href="https://lovable.dev/blog/one-year-of-lovable">100,000 new projects are built on Lovable every single day</a>.

### The `.ai` domain

{{ figure_markup(
  image="genai-ai-domain.png",
  caption="Usage of the .ai domain 2022 vs 2025 by rank.",
  description="Bar chart comparing the number of .ai domains before the ChatGPT release (June 2022) versus July 2025, grouped by site rank. Among the top 1k sites, usage grew from zero sites in 2022 to two in 2025. In the top 10k, it rose from 1 to 21. The trend accelerates in lower ranks: 17 vs. 180 in the top 100k, 273 vs. 1,606 in the top 1 million, and 2,824 vs. 11,848 in the top 10 million sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=702698195&format=interactive",
  sheets_gid="8436279",
  sql_file="ai_tld.sql"
  )
}}

While both AI and the `.ai` domain existed long before ChatGPT, the new possibilities that emerged in its wake led to a wave of AI-native businesses. Many of them adopted the `.ai` top-level domain, <a hreflang="en" href="https://www.iana.org/domains/root/db/ai.html">the country code for Anguilla</a>. This trend drove a substantial rise in `.ai` domain registrations across all ranks, as shown in the figure above, which compares the pre-ChatGPT landscape in 2022 with usage in 2025.

The only two `.ai` domains that made it into the top 1,000 most visited websites in the Chrome dataset were https://character.ai and an adult site.

## Conclusion

In 2025, Generative AI transitioned from a cloud-only technology to a fundamental browser component. BYOAI dominated immediate adoption, driven by the growth of foundational APIs, such as WebAssembly and WebGPU, as well as libraries like WebLLM and Transformers.js. At the same time, Built-in AI began laying the groundwork for a standardized AI layer directly within the browser. A tension has formed between more restrictive `robots.txt` files and the welcoming structure of `llms.txt`. The rise of vibe coding and `.ai` domains proves that AI isn't just reshaping how apps function, but also how they are built.

Looking beyond 2025, the next evolutionary leap is already visible: Agentic AI. We are moving away from the era of interactive chatbots toward autonomous agents that are capable of making decisions, executing multi-step workflows, and solving complex tasks without continuous user intervention. This shift is giving rise to a new class of "agentic browsers" such as [Perplexity Comet](https://www.perplexity.ai/comet), [ChatGPT Atlas](https://chatgpt.com/atlas/), or [Opera Neon](https://www.operaneon.com/).

To connect these agents to the vast resources of the web, new protocols such as [WebMCP](https://github.com/webmachinelearning/webmcp) (Web Model Context Protocol) are emerging. Just as HTTP standardizes the transmission of resources, WebMCP aims to standardize the way agents perceive and manipulate web interfaces, ensuring that the AI-native web is not only readable but also actionable.
