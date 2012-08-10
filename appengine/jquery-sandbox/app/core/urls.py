import webapp2

urlpatterns = [
    webapp2.Route('/', handler='core.views.Welcome', name='core:welcome', methods=['GET']),
    webapp2.Route('/sandbox/', handler='core.views.Sandbox', name='core:sandbox', methods=['GET']),
]
