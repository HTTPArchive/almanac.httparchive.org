import os
import re
import mistune
import yaml

renderer = mistune.Renderer()
markdown = mistune.Markdown(renderer=renderer)


def generate_chapters():
    for language_dir in os.scandir('content'):
        language = language_dir.name

        for year_dir in os.scandir(language_dir.path):
            year = year_dir.name

            for chapter_file in os.scandir(year_dir.path):
                chapter = re.sub('.md$', '', chapter_file.name)

                (metadata, body) = parse_file(chapter_file)

                write_template(language, year, chapter, metadata, body)


def parse_file(chapter_file):
    with open(chapter_file, 'r') as f:
        content = f.read()

    # This regex will match the metadata of the markdown file and the body of the
    # markdown file seperately. It disambiguiates the two by looking for '---' as a
    # line separation between the two sections. The metadata section (called front
    # matter) is essentially just YAML so can be parse directly into an object.
    # https://yaml.org/spec/1.2/spec.html#id2760395
    pattern = r'^\s*(?:-{3})(.*?)(?:-{3})\s*(.+)$'
    (metadata_text, body_text) = re.findall(
        pattern, content, re. DOTALL | re.MULTILINE)[0]

    metadata = yaml.load(metadata_text, Loader=yaml.SafeLoader)

    # TODO: Parse the body_text and find placeholders for generating embedded SVG.

    body = markdown(body_text)

    return (metadata, body)


def write_template(language, year, chapter, metadata, body):
    template_path = 'templates/%s/%s/chapter.html' % (language, year)

    with open(template_path, 'r') as template_file:
        template = template_file.read()

    path = 'templates/%s/%s/chapters/%s.html' % (language, year, chapter)

    with open(path, 'w') as file_to_write:
        file_to_write.write(template.format(body=body, metadata=metadata))


generate_chapters()
