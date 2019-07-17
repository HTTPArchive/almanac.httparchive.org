import os
import re
import mistune

renderer = mistune.Renderer()
markdown = mistune.Markdown(renderer=renderer)

# This could perhaps be loaded from an external file.
TEMPLATE = """
{{% extends "en/base.html" %}}

{{% block title %}}
Chapter {{{{ chapter }}}} | The Web Almanac by HTTP Archive
{{% endblock %}}

{{% block main %}}
{content}
{{% endblock %}}
"""


def generate_chapters():
    for language_dir in os.scandir('content'):
        language = language_dir.name

        for year_dir in os.scandir(language_dir.path):
            year = year_dir.name

            for chapter_file in os.scandir(year_dir.path):
                chapter = re.sub('.md$', '', chapter_file.name)

                content = get_content(chapter_file)
                write_template(language, year, chapter, content)


def get_content(chapter_file):
    with open(chapter_file, 'r') as f:
        content = f.read()
    return markdown(content)


def write_template(language, year, chapter, content):
    path = 'templates/%s/%s/chapters/%s.html' % (language, year, chapter)

    with open(path, 'w') as file_to_write:
        file_to_write.write(TEMPLATE.format(content=content))


generate_chapters()
