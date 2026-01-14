const fs = require('fs-extra');
const Tesseract = require('tesseract.js');
const { find_markdown_files } = require('./shared');

const generate_descriptions = async (chapter_match) => {
    let re;
    if (chapter_match) {
        chapter_match = chapter_match.replace(/\.md$/, '');
        chapter_match = chapter_match.replace(/^content[/\\]*/, '');
        chapter_match = (process.platform != 'win32')
            ? 'content/' + '(' + chapter_match.replace(/\//g, ')/(') + ').md'
            : 'content\\\\' + '(' + chapter_match.replace(/\//g, ')\\\\(') + ').md';
        re = new RegExp(chapter_match);
    } else {
        console.log('Please provide an argument of the form: en/2020/performance');
        process.exit(1);
    }

    const files = await find_markdown_files();

    for (const file of files) {
        let language, year, chapter;
        try {
            const match = file.match(re);
            if (!match) continue;
            [, language, year, chapter] = match;
        } catch {
            continue;
        }

        if (language !== "en") {
            console.log("Skipping non-English chapter");
            continue;
        }

        console.log(`Generating descriptions for the ${year} ${chapter} chapter:`);
        let markdown = await fs.readFile(file, 'utf-8');

        // Matches figure_markup and captures the content inside (...)
        const figure_regexp = /{{[\s]*figure_markup\(([\s\S]*?)\)[\s]*}}/g;

        // Collect all blocks first to avoid regex state issues during async/await
        const blocks = [];
        let match;
        while ((match = figure_regexp.exec(markdown)) !== null) {
            blocks.push({
                full: match[0],
                content: match[1]
            });
        }

        for (const block of blocks) {
            // Extract attributes
            const imageMatch = block.content.match(/image="([^"]*)"/);
            const descriptionMatch = block.content.match(/description="([^"]*)"/);

            const image_file = imageMatch ? imageMatch[1] : null;
            const current_description = descriptionMatch ? descriptionMatch[1] : "";

            if (image_file && current_description === "") {
                const image_path = `static/images/${year}/${chapter}/${image_file}`;
                if (fs.existsSync(image_path)) {
                    console.log(`  Processing OCR for ${image_file}...`);
                    try {
                        const result = await Tesseract.recognize(image_path, 'eng');
                        const text = result.data.text;

                        // Basic cleanup: remove newlines, collapse spaces, escape quotes
                        const description = text
                            .replace(/\n/g, ' ')
                            .replace(/\s+/g, ' ')
                            .trim()
                            .replace(/"/g, '\\"');

                        if (description) {
                            const updatedBlock = block.full.replace(/description=""/, `description="${description}"`);
                            // Use a more specific replacement if possible to avoid colliding with other identical blocks
                            // Since each block should have a unique image, we can use that to find the exact block if needed
                            // but simple string replacement works if each block is unique in the file.
                            markdown = markdown.replace(block.full, updatedBlock);
                        }
                    } catch (err) {
                        console.error(`  Error processing OCR for ${image_file}:`, err);
                    }
                } else {
                    console.log(`  Image not found: ${image_path}`);
                }
            }
        }

        await fs.writeFile(file, markdown);
        console.log(`Finished updating ${file}`);
    }
};

(async () => {
    try {
        const arg = process.argv.slice(2)[0];
        await generate_descriptions(arg);
    } catch (error) {
        console.error(error);
        process.exit(1);
    }
})();
