from django.urls import path
from .views import ArtistListCreate, ArtistDetail, AlbumListCreate, AlbumDetail, SongListCreate, SongDetail, LikedSongListCreate, LikedSongDetail
from .views import RegisterView
from .views import LoginView



urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),    
    path('login/', LoginView.as_view(), name='login'),
    path('artists/', ArtistListCreate.as_view(), name='artist-list-create'),
    path('artists/<int:pk>/', ArtistDetail.as_view(), name='artist-detail'),
    path('albums/', AlbumListCreate.as_view(), name='album-list-create'),
    path('albums/<int:pk>/', AlbumDetail.as_view(), name='album-detail'),
    path('songs/', SongListCreate.as_view(), name='song-list-create'),
    path('songs/<int:pk>/', SongDetail.as_view(), name='song-detail'),
    path('liked-songs/', LikedSongListCreate.as_view(), name='liked-song-list-create'),
    path('liked-songs/<int:pk>/', LikedSongDetail.as_view(), name='liked-song-detail'),
]