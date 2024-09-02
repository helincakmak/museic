from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('museic.urls')),  # `museic` uygulamanızın urls.py dosyasını dahil edin
]
