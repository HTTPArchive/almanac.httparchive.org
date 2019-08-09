import copy,re
from mistune import InlineLexer
import generate_visualisations

class VisualisationLexer(InlineLexer):
    def enable(self):
        self.rules.visualisation = re.compile(
            r'\[!\s?'       # [
            r'(.*)\('       # generate_histogram(
            r'(.*)\)'       # 2019, '01_01', 'kbytes', 'pdf', 'KB')
            r'\s?\|(.*)'    # Histogram of JavaScript Bytes
            r'\]'           # ]
        )

        self.default_rules.insert(0, 'visualisation')
        
        return self

    def output_visualisation(self, m):
        visualisation = m.group(1)
        raw_args = m.group(2)
        caption = m.group(3)
        print(' - Generating visualisation: %s' % visualisation)
        
        args = dict()
        for arg in raw_args.split(', '):
            key, value = tuple(arg.split('='))
            value = value.strip('\'')
            args[key] = value

        print(' - Using these parameters: %s' % args)

        function = getattr(generate_visualisations, visualisation)
        figure = function(**args)
        return '<figure>%s<figcaption>%s</figcaption></figure>' % (figure, caption)