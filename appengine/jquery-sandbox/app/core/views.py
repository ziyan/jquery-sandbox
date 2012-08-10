from core import web

class Welcome(web.View):
    def get(self):
        self.render('core/welcome.html')
