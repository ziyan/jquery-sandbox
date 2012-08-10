from core import web

class Welcome(web.View):
    @web.cache_control(max_age=86400)
    def get(self):
        self.render('core/welcome.html')

class Keepalive(web.View):
    def get(self):
        pass

class Sandbox(web.View):
    @web.cache_control(max_age=86400)
    def get(self):
        self.render('core/sandbox.html')
