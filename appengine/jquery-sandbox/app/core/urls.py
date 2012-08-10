import webapp2

urlpatterns = [
    webapp2.Route('/', handler='core.views.Welcome', name='core:welcome', methods=['GET']),
]
