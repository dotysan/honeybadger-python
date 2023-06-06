try:
    from django.urls import re_path
except:
    from django.conf.urls import url as re_path

from . import views

urlpatterns = [
    re_path(r'^greet$', views.greet, name='greet'),
    re_path(r'^div$', views.buggy_div, name='div'),
]
