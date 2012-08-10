import settings

def webapp_add_wsgi_middleware(app):
    if not settings.DEVELOPMENT:
        return app
    from google.appengine.ext.appstats import recording
    app = recording.appstats_wsgi_middleware(app)
    return app
