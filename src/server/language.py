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

    # Currently this returns the same as lang_code as we don't support regions
    @property
    def lang_attribute(self):
        return self._lang_code

    @property
    def lang_code(self):
        return self._lang_code


# Mostly we are region agnostic languages, but can add region where
# there are significant differences (e.g. Chinese)
class Language(object):
    EN = _Language('English', 'en', 'US')
    ES = _Language('Español', 'es', 'ES')
    FR = _Language('Français', 'fr', 'FR')
    JA = _Language('日本語', 'ja', 'JP')
    PT = _Language('Portuguese', 'pt', 'PT')
    ZH_CN = _Language('简体中文', 'zh-CN', 'CN')


DEFAULT_LANGUAGE = Language.EN


# Maps language codes to _Language objects.
language_map = {v.lang_code: v for k, v in Language.__dict__.items() if k[:1] != '_'}


def get_language(lang_code):
    return language_map.get(lang_code)
