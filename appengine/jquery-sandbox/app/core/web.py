from core import filters
import webapp2
import jinja2
import os
import settings

jinja_template_path = os.path.realpath(os.path.join(os.path.dirname(__file__), '..', 'template'))
jinja_loader = jinja2.FileSystemLoader(jinja_template_path)
jinja_environment = jinja2.Environment(
    loader=jinja_loader,
    extensions=[
        'jinja2htmlcompress.HTMLCompress',
        'jinja2.ext.autoescape',
        'jinja2.ext.with_',
        'jinja2.ext.loopcontrols',
        'jinja2.ext.do',
        'jinja2.ext.i18n',
    ],
    autoescape=True
)
jinja_environment.filters.update({
    'yesno': filters.yesno,
    'lines': filters.lines,
    'timestamp': filters.timestamp,
})
jinja_globals = {
    'webapp2': webapp2,
    'settings': settings,
}

jinja_environment.globals.update(jinja_globals)

class View(webapp2.RequestHandler):

    def __init__(self, *args, **kwargs):
        super(View, self).__init__(*args, **kwargs)
        self.ip = None

    def render_to_str(self, template, context=None):
        context = context or {}
        context.update({
            'ip': self.ip,
        })
        template = jinja_environment.get_template(template)
        return template.render(context)

    def render(self, template, context=None):
        self.response.out.write(self.render_to_str(template, context))
