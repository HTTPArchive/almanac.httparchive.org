import mistune

renderer = mistune.Renderer()
markdown = mistune.Markdown(renderer=renderer)


def validate_chapter(lang, year, chapter):
    # TODO
    return True


# TODO: Should this be cached in memory to prevent having to repeatedly
# open and read the file? It shouldn't lock, I'm just not sure how well
# this will perform in python.
def get_chapter(lang, year, chapter):
    file = 'templates/%s/%s/chapters/%s.md' % (lang, year, chapter)
    with open(file, "r") as f:
        content = f.read()

    return markdown(content)
