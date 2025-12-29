---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Generative AI
description: Generative AI chapter of the 2025 Web Almanac covering...
hero_alt: Hero image illustrating an AI-assisted web development workflow. Source code and image assets, marked with stars to indicate AI generation, flow into a pipeline where a red character feeds tokens and a blue brain-like character oversees the process, resulting in a fully rendered web page displayed in a browser window.
authors: [christianliebel, Yash-Vekaria, JonathanPagel]
reviewers: [tomayac, umariqbal]
analysts: [JonathanPagel, christianliebel, tomayac]
editors: [christianliebel]
translators: []
results: https://docs.google.com/spreadsheets/d/1q_hFsWlt6DZMmwnxrTmU3nCRjT2w38AomAlw8b_lthE/edit
christianliebel_bio: Christian Liebel, M.Sc., is an elected member of the <a hreflang="en" href="https://w3ctag.org/">W3C Technical Architecture Group</a> (TAG), a participant in the <a hreflang="en" href="https://webmachinelearning.github.io/">W3C Web Machine Learning</a> (WebML) Community and Working Groups, and a Google Developer Expert (GDE) for Web AI.
Yash-Vekaria_bio: Yash Vekaria is a PhD candidate in Computer Science at <a hreflang="en" href="https://www.ucdavis.edu/">University of California, Davis</a>. He carries out web-based large-scale Internet measurements to study and improve the dynamics of web. Specifically, his research is focused at studying and bringing transparency to online tracking practices and user privacy issues.
JonathanPagel_bio: Jonathan Pagel studied ecommerce in his bachelor's degree and has since been interested in the field, particularly in the areas of speed optimization and accessibility for shops and websites. Currently, he is freelancing in this field and pursuing a Master's in AI and Society.
featured_quote: In 2025, Generative AI transitioned from a cloud-only technology to a fundamental browser component.
featured_stat_1: 147%
featured_stat_label_1: Increase in WebGPU page loads
featured_stat_2: 340%
featured_stat_label_2: Increase in WebLLM npm downloads
featured_stat_3: 4.5%
featured_stat_label_3: Websites defining robots.txt rules for OpenAI's GPTBot
doi: ...
---

[On November 30, 2022](https://openai.com/index/chatgpt/), OpenAI launched a service called ChatGPT, a product that catapulted Generative Artificial Intelligence (Generative AI) from research labs into the daily lives of millions. This launch fundamentally changed user expectations regarding how applications and the web should function. Furthermore, the accompanying API gave software developers a powerful tool to make their applications significantly smarter.

Generative AI is a specialized field that focuses on processing and generating human-understandable content, including text, source code, images, videos, speech, and music. Large Language Models (LLMs) represent a significant component of this field. Trained on vast amounts of textual data, LLMs understand and generate natural language, expanding software architecture by enabling developers to process human language effectively for the first time. Recently, Generative AI features have been integrated into established applications, including Windows, Office, and Photoshop.

As Generative AI becomes increasingly widespread, this chapter examines its emerging trends on the web. Specifically, it focuses on the use of local Generative AI, enabled by "Built-in AI" and "Bring Your Own AI" approaches, the discoverability of Generative AI content via `llms.txt`, and the impact of Generative AI on content creation and source code (AI fingerprints).

## Technology Overview

In this section, we will explain the difference between cloud-based and local AI models, discuss the pros and cons of these approaches, and then examine local technologies in detail.

### Cloud vs. Local

Most people use Generative AI through cloud services such as OpenAI, Azure AI Foundry, AWS Bedrock, Google Cloud AI, or the DeepSeek Platform. Because these providers have access to immense computational resources and storage capacity, they offer several key advantages:

* High-quality responses: The models are extremely capable and powerful.
* Fast inference times: Responses are generated quickly on powerful servers.
* Minimal data transfer: Only input and output data need to be transmitted, not the entire AI model.
* Hardware independence: It works regardless of the client's computing resources.

However, cloud-based models also have their drawbacks:

* Connectivity: They require a stable internet connection.
* Reliability: They are subject to network latency, server availability, and capacity limits.
* Privacy: Data must be transferred to the cloud service, which raises potential privacy concerns. It is often unclear if user data is being used to train future model iterations.
* Cost: They usually require a subscription or API usage fees, so website authors often have to pay for the inference.

### Local AI technologies

The limitations of cloud-based systems can be addressed by migrating inference to the client via local AI technologies, [referred to as Web AI](https://developer.chrome.com/blog/io24-web-ai-wrapup#:~:text=Web%20AI%20is%20a%20set%20of%20technologies%20and%20techniques%20to%20use%20machine%20learning%20\(ML\)%20models%2C%20client%2Dside%20in%20a%20web%20browser%20running%20on%20a%20device%27s%20CPU%20or%20GPU.). Since models are downloaded to the user's system, their weights cannot be kept a secret. As a result, this approach is mostly used in combination with open-weights models, which are [typically less powerful than their commercial, cloud-based, closed-weights counterparts](https://www.vellum.ai/llm-leaderboard).

The [W3C Web Machine Learning](https://webmachinelearning.github.io/) Community Group (WebML CG) and Working Group (WebML WG) are actively standardizing this shift to make AI a first-class citizen of the web. This effort follows two primary architectural directions: Bring Your Own AI and Built-in AI.

#### Bring Your Own AI

In the Bring Your Own AI (BYOAI) model, the developer is responsible for shipping the model to the user. The web application downloads a specific model binary and executes it using low-level APIs on local hardware. This allows running highly specialized models, tailored to the use case, but also requires significant bandwidth.

There are [three processing units](https://www.w3.org/2024/01/webevolve-series-events/media/slides/hu-ningxin.pdf#page=4) that can be used to run AI inference locally:

* Central Processing Unit (CPU): Responds quickly, ideal for low-latency AI workloads.
* Graphics Processing Unit (GPU): High throughput, ideal for AI-accelerated digital content creation.
* Neural Processing Unit (NPU) or Tensor Processing Unit (TPU): Low power, ideal for sustained AI workloads and AI offload for battery life.

The three key APIs that facilitate local AI inference are WebAssembly (CPU), WebGPU (GPU), and WebNN (CPU, GPU, and NPU).

All statistics in this section refer to the percentage of Google Chrome page loads that utilize these APIs at least once, across all release channels and platforms. It is essential to note that the use of WebAssembly and WebGPU does not confirm AI activity; these are general-purpose APIs frequently utilized for tasks such as complex calculations, 3D visualizations, or gaming.

##### WebAssembly

[WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly) (Wasm) acts as the bytecode for the web. Code written in various programming languages, including C++ and Rust, can be compiled into WebAssembly. It enables developers to write optimized, high-performance code that is executed by the browser's scripting engine on the user's CPU.

<!-- markdownlint-disable-next-line MD051 -->
WebAssembly has broad browser support, being implemented in all relevant browser engines since 2017. In 2025, the usage of WebAssembly (i.e., the instantiation of a WebAssembly module relative to page loads) experienced 27% linear growth (see [Figure 1](#fig-1)) from being active on 4.44% of page loads in January, and 5.64% in December 2025 (January 2024: 3.37%).

{{ figure_markup(
  image="genai-wasm-usage.png",
  caption="WebAssembly usage in 2025 according to Chrome Platform Status data.",
  description="Bar chart showing the growth of WebAssembly usage in percent per page loads according to Chrome Platform Status data throughout 2025. Usage increased linearly from being active on 4.44% of page loads in January to 5.64% in December.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=148205691&format=interactive",
  sheets_gid="303424003"
  )
}}

##### WebGPU

[WebGPU](https://developer.mozilla.org/en-US/docs/Web/API/WebGPU_API) is the modern successor to [WebGL](https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API), designed to expose the capabilities of modern GPUs to the web. Unlike WebGL, which was strictly for graphics, WebGPU provides support for "compute shaders", allowing for general-purpose computing on graphics cards. This allows developers to perform massive parallel calculations, as required by AI models, directly on the user's graphics card.

<!-- markdownlint-disable-next-line MD051 -->
WebGPU has become the standard foundation for running AI workloads in the browser. With the release of Firefox 141 in November 2025, [WebGPU became available in all relevant browser engines](https://web.dev/blog/webgpu-supported-major-browsers) (Chromium, Gecko, and WebKit). In 2025, WebGPU experienced exponential growth in page loads, increasing by 147% (see [Figure 2](#fig-2)).

The July 2025 crawl of HTTPArchive data suggests that the API is used on 55,825 desktop sites and 68,043 mobile sites, a significant increase from 4,479 desktop and 4,742 mobile pages from the July 2024 crawl.

{{ figure_markup(
  image="genai-webgpu-usage.png",
  caption="WebGPU usage in 2025 according to Chrome Platform Status data.",
  description="Bar chart showing the growth of WebGPU usage in percent per page loads according to Chrome Platform Status data throughout 2025. Usage increased exponentially from being active on 0.77% of page loads in January to 1.9% in December.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=2117448035&format=interactive",
  sheets_gid="1071092495"
  )
}}

##### WebNN

The [Web Neural Network API](https://webnn.io/en) (WebNN) is a dedicated high-level API specifically for machine learning. It is specified by the WebML Working Group, meaning this API is on the W3C Recommendations track, which means it's on the way to becoming a Web standard.

WebNN serves as a hardware-agnostic abstraction layer, allowing the browser to route operations to the most efficient hardware available on the device. In contrast to WebAssembly (CPU-only) and WebGPU (GPU-only), WebNN can perform computations on the CPU, GPU, and NPU. This way, it can achieve near-native execution speeds.

<!-- markdownlint-disable-next-line MD051 -->
WebNN is in active development and is currently implemented behind a flag [in Chromium-based browsers](https://webnn.io/en/api-reference/browser-compatibility/api) on ChromeOS, Linux, macOS, Windows, and Android. In November 2025, [Firefox joined as the second engine formally supporting the API](https://github.com/mozilla/standards-positions/issues/1215#issuecomment-3520278819). Given that this is still an experimental API, the usage count is currently very low, with high fluctuation and a maximum of 0.000029% of page loads in February 2025 (see [Figure 3](#fig-3)).

{{ figure_markup(
  image="genai-webnn-usage.png",
  caption="WebNN usage in 2025 according to Chrome Platform Status data.",
  description="Bar chart showing the WebNN usage in percent per page loads according to Chrome Platform Status data throughout 2025. Adoption is extremely low and fluctuates, peaking at only 0.000029% of page loads in February, but also reaching 0% of page loads in May and July.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=2004233407&format=interactive",
  sheets_gid="939568069"
  )
}}

##### Runtimes: ONNX Runtime and Tensorflow.js

[ONNX Runtime](https://onnxruntime.ai/docs/tutorials/web/) (developed by Microsoft) and [Tensorflow.js](https://www.tensorflow.org/js) (developed by Google) are two of the leading runtimes for executing AI models directly in the browser. These runtimes abstract away the complexities of low-level technologies like WebAssembly (Wasm), WebGPU, and WebNN.

TensorFlow.js is tightly integrated with the TensorFlow ecosystem and supports both training and inference, while ONNX Runtime Web focuses on cross-platform inference using the ONNX standard, enabling models from multiple frameworks to run client-side.

<!-- markdownlint-disable-next-line MD051 -->
From January to November 2025, npm package downloads of ONNX Runtime increased by 185%, while TensorFlow.js's downloads increased by 70% (see [Figure 4](#fig-4)), demonstrating strong and growing developer interest in browser-based AI.

{{ figure_markup(
  image="genai-runtime-downloads.png",
  caption="npm package downloads of @tensorflow/tfjs and onnxruntime-web.",
  description="Bar chart comparing the npm package download numbers of the AI runtimes ONNX Runtime and Tensorflow.js from January to November 2025. ONNX Runtime downloads grew rapidly from 773,018 downloads in January to 2,204,245 in November, while Tensorflow.js only grew from 509,599 to 869,680 downloads in the same period.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=2128444354&format=interactive",
  sheets_gid="815003361"
  )
}}

##### Libraries: WebLLM and Transformers.js

[WebLLM](https://webllm.mlc.ai/), developed by the MLC AI research team, is a high‑performance in‑browser inference engine specialized for LLMs. It allows running various open-weights LLMs, including Llama, Phi, Gemma, or Mistral, directly in the browser. Currently, WebLLM uses WebGPU for inference.

<!-- markdownlint-disable-next-line MD051 -->
WebLLM has quickly become one of the most prominent solutions for in‑browser LLM inference. Between January and November 2025, WebLLM package downloads from npm increased by 340%, with nearly double the npm downloads occurring in August alone (see [Figure 5](#fig-5)).

{{ figure_markup(
  image="genai-webllm-downloads.png",
  caption="npm package downloads of @mlc-ai/web-llm.",
  description="Bar chart showing npm downloads for the @mlc-ai/web-llm package from January to November 2025. Downloads increased by 340% from 23,425 package downloads in January to 103,084 downloads in November, with a significant spike occurring in August where downloads nearly doubled from 57,114 in July to 102,440 in August.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=672596885&format=interactive",
  sheets_gid="87936740"
  )
}}

[Transformers.js](https://huggingface.co/docs/transformers.js/index), developed by [Hugging Face](https://huggingface.co/), functions as a comprehensive JavaScript library that mirrors the popular Python `transformers` API. Under the hood, it relies on ONNX Runtime Web to execute. It allows developers to run pre-trained models for various tasks through simple high-level pipelines, not just LLMs.

<!-- markdownlint-disable-next-line MD051 -->
From January to November 2025, the npm package downloads almost tripled, also with a notable surge in August 2025 (see [Figure 6](#fig-6)).

{{ figure_markup(
  image="genai-tfjs-downloads.png",
  caption="npm package downloads of @huggingface/transformers.",
  description="Bar chart showing npm downloads for the @huggingface/transformers package from January to November 2025. Downloads nearly tripled from 240,389 in January to 719,103 in November. The trend highlights a significant spike in August, reaching a year-to-date peak of 758,393.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1045307255&format=interactive",
  sheets_gid="303133226"
  )
}}

#### Built-in AI: Prompt API and task-specific APIs

[Built-in AI](https://developer.chrome.com/docs/ai/built-in) is an initiative by Google and Microsoft that aims to provide high-level AI APIs to web developers. Unlike BYOAI, this approach leverages models facilitated by the browser itself. While developers cannot specify an exact model, this method allows all websites to share the same model, meaning it only needs to be downloaded once.

The initiative consists of multiple APIs:

* Prompt API: Gives developers low-level access to a local LLM.
* Task-specific APIs:
  * Writing Assistance APIs: Summarizing, writing, and rewriting text.
  * Proofreader API: Finding and fixing mistakes in text.
  * Language Detector and Translator APIs: Detecting the language of text content and translating it into another language.

All APIs are specified within the WebML Community Group, meaning they are still incubating and not yet on the W3C Recommendations track. Some of the APIs are already generally available, while others are in Origin Trial or need a browser flag to be enabled—unlike WebGPU, which is now stable and widely available for shipping production features.

<!-- markdownlint-disable-next-line MD051 -->
The package of TypeScript typings for Built-in AI (see [Figure 7](#fig-7)) may reflect the experimental status of the APIs. Downloads peaked in August 2025 with 25,770 downloads, followed by a gradual decline. This trend may suggest that developers are hesitant to adopt experimental APIs. However, the download statistics for a typings package may not reflect the actual usage of the API.

{{ figure_markup(
  image="genai-typings-downloads.png",
  caption="npm package downloads of @types/dom-chromium-ai.",
  description="Bar chart showing npm downloads for the @types/dom-chromium-ai package from January to November 2025. Downloads started at 2,653 in January, peaked at 25,770 in August, and followed a gradual decline to 12,478 in November.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=83152267&format=interactive",
  sheets_gid="232169116"
  )
}}

The data presented in this section is based on a July 2025 crawl of the HTTP Archive. Websites were scanned for the presence of specific API calls. Please note that this indicates the occurrence of the code, but not necessarily its actual usage.

##### Prompt API

The Prompt API introduces a standardized interface for accessing LLMs facilitated by the user's browser, such as Gemini Nano in Chrome or [Phi-4-mini in Edge](https://learn.microsoft.com/en-us/microsoft-edge/web-platform/prompt-api). By leveraging these one-time-download models, the API eliminates the bandwidth barriers and cold-start latency associated with libraries that require downloading model weights.

However, as of December 2025, the technology remains in a transitional phase: it has fully shipped for browser extensions in Chrome 138, but web page access is still restricted to an Origin Trial. In this controlled experiment, developers must register specific tokens to bypass feature flags. The API is not currently available on mobile devices.

<!-- markdownlint-disable-next-line MD051 -->
Consequently, adoption remains nascent; HTTP Archive data from July 2025 (the first measurement available) detected the API on just 27,047 desktop sites (0.0009%) and 17,902 mobile sites (0.0008%), reflecting its current status as an experiment rather than a standard utility (see [Figure 8](#fig-8)).

Most of the example sites we analyzed used the Prompt API through an external script, [Google Publisher Tags](https://developers.google.com/publisher-tag/guides/get-started). This project enables authors to incorporate dynamic advertisements into their websites. The [Google Publisher Tags script](https://securepubads.g.doubleclick.net/pagead/managed/js/gpt/m202512040101/pubads_impl.js) uses the Prompt API to categorize the page's content into a list of the [Interactive Advertising Bureau (IAB) Content Taxonomy 3.1 categories](https://github.com/InteractiveAdvertisingBureau/Taxonomies/blob/develop/Content%20Taxonomies/Content%20Taxonomy%203.1.tsv), and the Summarizer API (see next section) to generate a summary of the page's content, and sends both to the server. However, the code branch didn't seem to be active during our analysis.

{{ figure_markup(
  image="genai-prompt-api-adoption.png",
  caption="Prompt API adoption.",
  description="Bar chart comparing the adoption of the Prompt API on desktop and mobile sites during the July 2025 crawl. The API was detected on 27,047 desktop sites and 17,902 mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1191364409&format=interactive",
  sheets_gid="1142091854",
  sql_file="../capabilities/fugu.sql"
  )
}}

##### Writing Assistance APIs and Proofreader API

Next, we examine the task-specific APIs: The [Writing Assistance APIs](https://learn.microsoft.com/en-us/microsoft-edge/web-platform/writing-assistance-apis) abstract the complexities of prompt engineering; they utilize the same underlying embedded LLM but apply specialized system prompts to achieve distinct linguistic goals:

* Writer API: creates new content based on a prompt
* Rewriter API: rephrases input based on a prompt
* Summarizer API: produces a summary of text

Additionally, the [Proofreader API](https://developer.chrome.com/docs/ai/proofreader-api) enables developers to proofread text and correct grammatical errors and spelling mistakes.

The Summarizer API shipped with Chrome 138. As of December 2025, the Writer, Rewriter, and Proofreader API are in Origin Trial. All APIs are not currently available on mobile devices.

In the July 2025 HTTP Archive crawl, only calls to `Writer.create()` were detected (on 39,101 mobile and 29,208 desktop sites), which may indicate usage of the Writer API. While this initially suggested usage of the Writer API, manual checks revealed that many sampled sites were actually using [Protobuf.js's Writer](https://github.com/protobufjs/protobuf.js/blob/827ff8e48253e9041f19ac81168aa046dbdfb041/src/writer.js#L142), which shares the same API signature. As a result, we have decided to omit the chart for this metric.

##### Translator and Language Detector APIs

The final category of the Built-in AI APIs consists of the Translator and Language Detector APIs. Unlike the writing tools, these APIs do not rely on LLMs, but instead utilize specialized, task-specific neural networks, placing them outside the strict definition of Generative AI.

The APIs shipped in Chrome 138 but are not currently available on mobile devices.

<!-- markdownlint-disable-next-line MD051 -->
They have achieved the widest adoption of the Built-in AI APIs. The July 2025 HTTP Archive crawl detected these APIs on approximately 63,000 desktop and 74,000 mobile sites (\~0.003% of the web). Many of the sample sites we checked utilized the review tool [Judge.me](http://Judge.me), which serves as an add-on for Shopify stores. Judge.me [utilizes both the Language Detector and Translator APIs](https://judge.me/help/en/articles/11379816-translating-reviews-in-the-review-widget), which may be the reason for the tight coupling of usage: The Language Detector API was present on nearly the same number of sites, trailing the Translator API by only \~100 sites (see [Figure 9](#fig-9)).

{{ figure_markup(
  image="genai-translator-language-detector-adoption.png",
  caption="Translator and Language Detector API adoption.",
  description="Bar chart comparing the adoption of the Translator and Language Detector APIs on desktop and mobile sites during the July 2025 crawl. The adoption rates are nearly identical: the Translator API was found on 63,586 desktop and 74,845 mobile sites, while the Language Detector API appeared on 63,431 desktop and 74,709 mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=463876937&format=interactive",
  sheets_gid="1189045533",
  sql_file="../capabilities/fugu.sql"
  )
}}

#### Browser-specific runtimes: Firefox AI Runtime

As an alternative to the Built-in AI APIs proposed by the Chromium side, Firefox experiments with the [Firefox AI Runtime](https://firefox-source-docs.mozilla.org/toolkit/components/ml/index.html), a local inference runtime based on Transformers.js and the ONNX Runtime, which runs natively. However, the runtime is not yet accessible from the public web. It can only be used by extensions and other privileged uses, such as the [built-in translation feature](https://www.firefox.com/en-US/features/translate/) of Firefox.

## Discoverability

In this section, we look at the dynamics of web discoverability with increasing adoption of Generative AI on the web. We primarily focus on two important approaches that dictate discoverability of websites via AI-based platforms and services.

### **robots.txt**

The `robots.txt` file, located at the root of a domain (for example, `http://example.com/robots.txt`), allows website owners to declare crawl directives for automated bots. Beyond traditional crawlers, in the age of Generative AI, websites can also be crawled by AI-powered agentic crawlers or by model providers to collect internet-scale data for training their LLMs. As a result, websites have increased their reliance on `robots.txt` files to express their content-access preferences to these crawlers.

An example `robots.txt` directive to instruct a User-Agent string containing OpenAI's GPTBot to not crawl the site can be expressed as follows:

```
User-Agent: GPTBot
Disallow: /
```

It's important to note that adherence to `robots.txt` is voluntary and does not, by itself, restrict access to bots.

{{ figure_markup(
  image="genai-robots-txt-adoption.png",
  caption="`robots.txt` adoption.",
  description="Bar chart comparing sites with and without `robots.txt`. A significant 94.12% of sites serve the file.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1609639660&format=interactive",
  sheets_gid="342591090",
  sql_file="sites-with-robot-txt.sql"
  )
}}

<!-- markdownlint-disable-next-line MD051 -->
We note that `robots.txt` remains highly prevalent: approximately 94.1% of the \~12.9 million sites studied include a `robots.txt` file with at least one directive (see [Figure 10](#fig-10)). [Figure 11](#fig-11) describes the top 25 directives observed across all websites by their rank groups. The wildcard directive `*` can be seen to be the most commonly used one, present in 97.4% of `robots.txt` files. This directive can be used to allow and/or disallow a part or all of the site's content to "all" bots. The second most common directive is `gptbot`, which is OpenAI's bot used to crawl websites for model training purposes. The adoption of this directive has increased from 2.6% in [2024](https://almanac.httparchive.org/en/2024/seo#ai-crawlers) to around 4.5% in 2025.

{{ figure_markup(
  image="genai-robots-txt-directives.png",
  caption="top `robots.txt` directives by website ranks.",
  description="Bar chart ranking the most common `robots.txt` User-Agent directives by site rank. The wildcard `*` is the most common directive, followed by the `gptbot` directive. The next AI bot, `claudebot`, is on eighth position. Top 1k sites tend to mention bots more often than less popular sites. For example, `gptbot` is mentioned in the `robots.txt` file of 20.9% of top 1k sites, 12.1% of top 10k sites, 6.1% of top 100k sites, 3.6% of top 1 million sites, and 4% of top 10 million sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1897808878&format=interactive",
  width="621",
  height="845",
  sheets_gid="342591090",
  sql_file="user-agent-named.sql"
  )
}}

The other popular AI bots are the ones by Anthropic (claudebot, anthropic-ai, claude-web), Google (google-extended), OpenAI (chatgpt-user), and Perplexity (perplexitybot), among other less popular ones. The prevalence of AI bots is much higher on `robots.txt` of popular websites, almost all of them disallowing the bots. This is likely because popular websites can afford to block AI crawlers, without significantly hurting their website traffic due to their popularity. Overall, we observe an increase in adoption of AI User-Agent bots in `robots.txt` files.

### **llms.txt**

The [`llms.txt` file](https://www.google.com/url?q=https://llmstxt.org/&sa=D&source=docs&ust=1765009151034474&usg=AOvVaw1DImS9NJhBExlbvIk8twdl) is an emerging proposal that allows a website to provide information to help LLMs use a website at inference time. Like the `robots.txt`, it is also hosted at the root of a website's domain (for example, `https://example.com/llms.txt`). Distinctively, `robots.txt` instructs (AI) bots as to what are they allowed or disallowed to crawl during training phase or inference phase, while `llms.txt` provides structured and machine-readable format of website's content that allows large language models to discover and navigate through a website's content in real-time while answering a user's query.

{{ figure_markup(
  image="genai-llms-txt-adoption.png",
  caption="`llms.txt` adoption.",
  description="Bar chart comparing desktop and mobile sites with and without `llms.txt`. The file is only present on 2.13% of desktop and 2.1% of mobile sites, and absent on the vast majority of 97.87% desktop and 97.9% of mobile sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1543827839&format=interactive",
  sheets_gid="187293662"
  )
}}

<!-- markdownlint-disable-next-line MD051 -->
As `llms.txt` is relatively new, we observe very limited current usage of `llms.txt` on the web. Across desktop pages, 2.13% exhibit valid `llms.txt` entries, while 97.87% show no evidence of LLM-specific policies. Mobile shows a similar pattern, with 2.10% of pages containing valid entries and 97.90% lacking them (see [Figure 12](#fig-12)). The overwhelming majority of sites therefore do not yet articulate explicit AI-access preferences via `llms.txt`. Where present, `llms.txt` primarily indicates that early adopters may be experimenting with facilitating AI-driven discoverability of the website or offered services via agentic use-cases or generative AI optimization.

## AI Fingerprints

Services such as ChatGPT, Gemini, and Copilot are already widely used. Increasingly, content is being written with the assistance of AI. This section analyzes the impact of Generative AI on web content and source code.

### Lexical overrepresentation

Models can tend to overrepresent certain words, which then serve as an AI fingerprint. Researchers at Florida State University compared research papers published on PubMed between 2020 and 2024. [Their analysis](https://aclanthology.org/2025.coling-main.426.pdf%20) revealed a staggering 6,697.14% increase in the use of the word "delves." The other conjugations of the word "delve" have also increased significantly. While those kinds of indicators should never be used to classify individual cases as AI-generated, they are still useful for understanding the trend of adoption. In this part of the chapter, we will delve into ;) common patterns used by LLM to generate Websites.

{{ figure_markup(
  content="6,697.14%",
  caption="Usage increase of the word \"delves\" in research papers published on PubMed",
  classes="big-number",
) }}

The first indicator that comes to mind is the use of purple and gradients, often referred to as "the AI [Purple Problem](https://ai-engineering-trend.medium.com/the-mystery-behind-ais-purple-problem-revealed-0234afdb292e)." It describes the tendency of common LLMs to use a lot of purple when generating websites. Adam Wathan, creator of the widely adopted CSS framework Tailwind, explains in an interview that this may be because the Tailwind team used a lot of purple in their documentation and examples shortly before the first major crawls from AI labs began harvesting the internet. They did so to capture design trends of early 2020; a purple website a few years ago was as common as black in today's web design. However, LLMs do not seem to have noticed the more recent changes in design trends.

To quantify the "AI Purple" aesthetic, we analyzed the CSS (responsible for website styling) of all root pages in our dataset from the years following the adoption of ChatGPT. We tracked the presence of the well-known indigo color (`#6366f1`), the use of gradients, and other colors associated with AI-generated websites.

<!-- markdownlint-disable-next-line MD051 -->
Since Tailwind is the framework of choice for LLMs like Claude, Gemini, and the OpenAI models, we specifically examined the percentage of Tailwind websites using these indicators. Tailwind webpages were identified using a [Wappalyzer fork](https://github.com/HTTPArchive/wappalyzer) from the HTTPArchive. Surprisingly, there is no noticeable surge in websites using either indigo-500 or the other two commonly mentioned AI colors (`#8b5cf6` violet and `#a855f7` purple), as demonstrated by [Figure 14](#fig-14).

{{ figure_markup(
  image="genai-ai-colors-tailwind.png",
  caption="Usage of \"AI colors\" over the years in Tailwind pages.",
  description="Line chart comparing the usage of the aforementioned AI colors and indigo-500 on Tailwind pages, based on quarterly HTTPArchive crawls since Q3 2022. Both lines follow a similar pattern, with usage rates fluctuating around 2% of Tailwind pages. There is no noticeable surge in the usage of either color.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1045089879&format=interactive",
  width="642",
  height="417",
  sheets_gid="1065437374"
  )
}}

<!-- markdownlint-disable-next-line MD051 -->
Thanks to the rise in popularity of Tailwind itself, those Tailwind-specific colors saw a real surge when analyzed as a percentage of all websites, as shown by [Figure 15](#fig-15).

{{ figure_markup(
  image="genai-ai-colors.png",
  caption="Usage of \"AI colors\" over the years.",
  description="Line chart comparing the use of the aforementioned AI colors and indigo-500 across all pages, based on quarterly HTTPArchive crawls since Q3 2022. Their use rose from 0.02% (purple) and 0.03% (indigo-500) in Q3 2022 to 0.49% (purple) and 0.54% (indigo-500) in Q4 2025, with indigo-500 becoming slightly more popular.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=428756366&format=interactive",
  width="642",
  height="417",
  sheets_gid="1065437374",
  )
}}

Our analysis relies solely on CSS variables, since parsing the entire source code would exceed practical limits. As a result, our data significantly undercounts the total number of purple websites. Sites using hardcoded hex values (e.g., `#6366f1`) or older preprocessors are effectively invisible to our queries. Furthermore, we only detected specific default hex codes; even a 1% adjustment to a color's lightness would evade detection. This makes our "Tailwind Saturation" metric a conservative estimate.

Nevertheless, it is striking how often specific colors are discussed in the context of "AI slop," while too few of these supposed examples appear in the HTTPArchive dataset to show a real increase—at least not one that can't be explained by the general rise of Tailwind.

We also tested for gradients, shadows, and specific fonts, but found no meaningful surge.

### Vibe Coding Platforms

One of the reasons for the large number of newly created websites is the emergence of platforms that make building them easier. After the spread of CMS tools in the previous decade, users can now move beyond those guardrails and use tools like v0, Replit, or Lovable to generate websites with the help of AI. Users can publish pages under their own domains or under a platform-provided subdomain (for example, mywebsite.tool.com). The chart below shows the growth in the number of such subdomains that received enough visits to appear in the HTTPArchive dataset.

<!-- markdownlint-disable-next-line MD051 -->
Vercel dominates, though it offered hosting under subdomains long before the release of its vibe coding tool v0 in late 2023, and the data shows no noticeable surge afterward. Lovable, on the other hand, grew from only 10 subdomains in our data at the beginning of 2025 to 315 by October 2025 (see [Figure 16](#fig-16)).

{{ figure_markup(
  image="genai-vibe-coding-subdomains.png",
  caption="Subdomains of vibe coding platforms.",
  description="Line chart comparing the count of vibe coding platform subdomains relative to the entire HTTPArchive dataset, based on quarterly crawls since Q1 2020. Vercel leads the trend, rising steadily from 2021 to reach nearly 0.04% of all sites by October 2025, while newer entrants like Lovable and Replit show visible adoption beginning in early 2025.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=1670163713&format=interactive",
  width="797",
  height="417",
  sheets_gid="2051033428",
  sql_file="vibecodetools.sql"
  )
}}

### The .ai domain

<!-- markdownlint-disable-next-line MD051 -->
While both AI and the .ai domain existed long before ChatGPT, the new possibilities that emerged in its wake led to a wave of AI-native businesses. Many of them adopted the .ai top-level domain, the country code for Anguilla. This resulted in a substantial rise in .ai domain records across all ranks, as shown in [Figure 17](#fig-17) below comparing the pre-ChatGPT moment in 2022 with usage in 2025.

The only .ai domains that made it into the top 1000 most visited websites in the Chrome dataset are character.ai and a single adult site.

{{ figure_markup(
  image="genai-ai-domain.png",
  caption="Usage of the .ai domain 2022 vs 2025 by rank.",
  description="Bar chart comparing the number of .ai domains before the ChatGPT release (June 2022) versus July 2025, grouped by site rank. Among the top 1k sites, usage grew from 0 in 2022 to 2 in 2025. In the top 10k, it rose from 1 to 21. The trend accelerates in lower ranks: 17 vs. 180 in the top 100k, 273 vs. 1,606 in the top 1 million, and 2,824 vs. 11,848 in the top 10 million sites.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTXSz19p32lprObXmLblQxEy5u0Sjd9QajNixDEOJutiaxi1aWk37ojoY5Z3D-GfgHg3Ggu23VZS2yI/pubchart?oid=702698195&format=interactive",
  sheets_gid="8436279",
  sql_file="ai_tld.sql"
  )
}}

## Conclusion

In 2025, Generative AI transitioned from a cloud-only technology to a fundamental browser component. BYOAI dominated immediate adoption, driven by the growth of foundational APIs, such as WebAssembly and WebGPU, as well as libraries like WebLLM and Transformers.js. At the same time, Built-in AI began laying the groundwork for a standardized AI layer directly within the browser. A tension has formed between more restrictive `robots.txt` files and the welcoming structure of `llms.txt`. The rise of vibe coding and .ai domains proves that AI isn't just reshaping how apps function, but also how they are built.

Looking beyond 2025, the next evolutionary leap is already visible: Agentic AI. We are moving away from the era of interactive chatbots toward autonomous agents that are capable of making decisions, executing multi-step workflows, and solving complex tasks without continuous user intervention. This shift is giving rise to a new class of "agentic browsers" such as [Perplexity Comet](https://www.perplexity.ai/comet), [ChatGPT Atlas](https://chatgpt.com/atlas/), or [Opera Neon](https://www.operaneon.com/).

To connect these agents to the vast resources of the web, new protocols such as [WebMCP](https://github.com/webmachinelearning/webmcp) (Web Model Context Protocol) are emerging. Just as HTTP standardizes the transmission of resources, WebMCP aims to standardize the way agents perceive and manipulate web interfaces, ensuring that the AI-native web is not only readable but also actionable.
