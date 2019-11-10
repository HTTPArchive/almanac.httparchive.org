# coding=utf-8
class _Language(object):
  def __init__(self, local_name, lang_code, region_code):
    self._local_name = local_name
    self._lang_code = lang_code
    self._region_code = region_code

  def __eq__(self, other):
    if isinstance(other, _Language):
      return '%r' % self == '%r' % other
    return False

  def __str__(self):
    return '%s' % (self._local_name)

  def __repr__(self):
    return '%s, %s' % (self.__str__(), self.lang_attribute)

  @property
  def lang_attribute(self):
    # Returns the language attribute (eg "en-US") to be used in HTML.
    return '%s-%s' % (self._lang_code, self._region_code)

  @property
  def lang_code(self):
    return self._lang_code

class Language(object):
  JAPANESE = _Language('日本語', 'ja', 'JP')
  ENGLISH = _Language('English', 'en', 'US')
  SPANISH = _Language('Español', 'es', 'ES')

DEFAULT_LANGUAGE = Language.ENGLISH

# Maps language codes to _Language objects.
language_map = {v.lang_code: v for k,v in Language.__dict__.items() if k[:1] != '_'}

def get_language(lang_code):
  return language_map.get(lang_code)