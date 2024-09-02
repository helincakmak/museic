from rest_framework import serializers
from .models import Song, Album, Artist

class ArtistSerializer(serializers.ModelSerializer):
    class Meta:
        model = Artist
        fields = '__all__'  # Tüm alanları dahil eder

class AlbumSerializer(serializers.ModelSerializer):
    artist = ArtistSerializer()  # Albüm ile ilişkili sanatçıyı seri hale getirir

    class Meta:
        model = Album
        fields = '__all__'  # Tüm alanları dahil eder

class SongSerializer(serializers.ModelSerializer):
    album = AlbumSerializer()  # Şarkı ile ilişkili albümü seri hale getirir

    class Meta:
        model = Song
        fields = '__all__'  # Tüm alanları dahil eder
