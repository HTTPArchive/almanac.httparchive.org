import os
import re
import mistune
from mistune_contrib.toc import TocMixin
import yaml
from visualisation_lexer import VisualisationLexer
import config as config_util
import jinja2

class TocRenderer(TocMixin, mistune.Renderer):
  
    def header(self, text, level, raw=None):
        title =  re.sub('[\W_]+', ' ', text, flags=re.UNICODE).lower().replace(' ','-')
        rv = '<h%d id="toc-%s">%s</h%d>\n' % (
            level, title, text, level
        )
        self.toc_tree.append((self.toc_count, text, level, raw))
        self.toc_count += 1
        return rv

    def _iter_toc(self, level):
        first_level = 0
        last_level = 0

        yield '<ul>\n'

        for toc in self.toc_tree:
            index, text, l, raw = toc
            title = re.sub('[\W_]+', ' ', text, flags=re.UNICODE).lower().replace(' ','-')
            if l > level:
                # ignore this level
                continue

            if first_level == 0 :
                # based on first level
                first_level = l
                last_level = l
                yield '<li><a href="#toc-%s">%s</a>' % (title, text)
            elif last_level == l:
                yield '</li>\n<li><a href="#toc-%s">%s</a>' % (title, text)
            elif last_level == l - 1:
                last_level = l
                yield '<ul>\n<li><a href="#toc-%s">%s</a>' % (title, text)
            elif last_level > l:
                # close indention
                yield '</li>'
                while last_level > l:
                    yield '</ul>\n</li>\n'
                    last_level -= 1
                yield '<li><a href="#toc-%s">%s</a>' % (title, text)

        # close tags
        yield '</li>\n'
        while last_level > first_level:
            yield '</ul>\n</li>\n'
            last_level -= 1

        yield '</ul>\n'

toc = TocRenderer()
inline = VisualisationLexer(toc).enable()
markdown = mistune.Markdown(renderer=toc, inline=inline)

def generate_chapters():
    for language_dir in os.scandir('content'):
        language = language_dir.name

        for year_dir in os.scandir(language_dir.path):
            year = year_dir.name

            for chapter_file in os.scandir(year_dir.path):
                chapter = re.sub('.md$', '', chapter_file.name)
                print('\n Generating chapter: %s, %s, %s' % (chapter, year, language))

                (metadata, body, tochtml) = parse_file(chapter_file)
                write_template(language, year, chapter, metadata, body, tochtml)


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
    toc.reset_toc() 
    body = markdown.parse(body_text)
    tochtml=toc.render_toc(level=2)
    return (metadata, body, tochtml)

def generate_author_html(lang,year, metadata):
    config = config_util.get_config(year)
    authors = []
    for userid in metadata['authors']:
        author = config['contributors'].get(userid)
        if author is not None:
            authors.append(author)  

    return jinja2.Environment(
        loader=jinja2.FileSystemLoader('templates')
    ).get_template('%s/%s/chapter_author.html' % (lang, year)).render(authors=authors)
       

def write_template(language, year, chapter, metadata, body, tochtml):
    template_path = 'templates/%s/%s/chapter.html' % (language, year)

    with open(template_path, 'r') as template_file:
        template = template_file.read()

    path = 'templates/%s/%s/chapters/%s.html' % (language, year, chapter)

    
    authors = generate_author_html(language, year, metadata)
    prevnext = generate_prevnext_html(language, year, metadata['chapter_number'])
    with open(path, 'w') as file_to_write:
        file_to_write.write(template.format(body=body, metadata=metadata, toc=tochtml, authors=authors, prevnext=prevnext))
        print(' - Output file size: %s' % size_of(file_to_write.tell()))


def size_of(num, suffix='B'):
    for unit in ['','K','M','G']:
        if abs(num) < 1024.0:
            return "%3.1f%s%s" % (num, unit, suffix)
        num /= 1024.0
    return "%.1f%s%s" % (num, 'Yi', suffix)


def generate_prevnext_html(lang,year,chapter_no):
    config = config_util.get_config(year)
    chapter_no = str(chapter_no)
    prev_chapter = False
    next_chapter = False
    found =  False

    for part in config['outline']:
        for chapter in part['chapters']:
            if found:
                next_chapter = chapter
                break
            elif chapter['chapter'] == chapter_no:
                found = True
            else:
                prev_chapter = chapter
        if(found):
            break

    return jinja2.Environment(
        loader=jinja2.FileSystemLoader('templates')
    ).get_template('%s/%s/chapter_prevnext.html' % (lang, year)).render(lang=lang, year=year, prev_chapter=prev_chapter,next_chapter=next_chapter)

generate_chapters()