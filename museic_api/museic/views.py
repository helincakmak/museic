from rest_framework.response import Response
from rest_framework import generics, status
from .models import Song, Album, Artist, LikedSong
from .serializers import SongSerializer, AlbumSerializer, ArtistSerializer, LikedSongSerializer
from rest_framework.permissions import IsAuthenticated
from rest_framework.permissions import AllowAny
from .serializers import RegisterSerializer
from rest_framework_simplejwt.tokens import RefreshToken
from .serializers import LoginSerializer
from .serializers import UserSerializer
from .serializers import RegisterSerializer
from django.contrib.auth import authenticate
from .models import Song


class LoginView(generics.GenericAPIView):
    serializer_class = LoginSerializer
    permission_classes = [AllowAny]

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = authenticate(
            username=serializer.validated_data['username'],
            password=serializer.validated_data['password']
        )
        if user is not None:
            refresh = RefreshToken.for_user(user)
            return Response({
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            })
        return Response({'error': 'Geçersiz giriş bilgileri'}, status=status.HTTP_401_UNAUTHORIZED)



class RegisterView(generics.CreateAPIView):
    serializer_class = RegisterSerializer


# Artist API Views
class ArtistListCreate(generics.ListCreateAPIView):
    queryset = Artist.objects.all()
    serializer_class = ArtistSerializer

class ArtistDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Artist.objects.all()
    serializer_class = ArtistSerializer

# Album API Views
class AlbumListCreate(generics.ListCreateAPIView):
    queryset = Album.objects.all()
    serializer_class = AlbumSerializer

class AlbumDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Album.objects.all()
    serializer_class = AlbumSerializer

# Song API Views
class SongListCreate(generics.ListCreateAPIView):
    queryset = Song.objects.all()
    serializer_class = SongSerializer

class SongDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Song.objects.all()
    serializer_class = SongSerializer

# Liked Songs API Views

class LikedSongListCreate(generics.ListCreateAPIView):
    serializer_class = LikedSongSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return LikedSong.objects.filter(user=self.request.user)

    def create(self, request, *args, **kwargs):
        song_id = request.data.get('song_id')
        user = request.user

        if not song_id:
            return Response({"error": "Şarkı ID'si gerekli."}, status=status.HTTP_400_BAD_REQUEST)

        song = generics.get_object_or_404(Song, id=song_id)
        liked_song, created = LikedSong.objects.get_or_create(user=user, song=song)

        if not created:
            liked_song.delete()
            return Response({"message": "Beğeni kaldırıldı."}, status=status.HTTP_204_NO_CONTENT)

        return Response({"message": "Şarkı beğenildi."}, status=status.HTTP_201_CREATED)


    
class LikedSongDetail(generics.RetrieveDestroyAPIView):
    queryset = LikedSong.objects.all()
    serializer_class = LikedSongSerializer
    permission_classes = [IsAuthenticated]
