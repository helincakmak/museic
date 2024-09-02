from django.db import models

class Artist(models.Model):
    name = models.CharField(max_length=100, help_text="Artist's name")
    genre = models.CharField(max_length=100, help_text="Music genre of the artist")

    def __str__(self):
        return self.name


class Song(models.Model):
    title = models.CharField(max_length=100, help_text="Title of the song")
    artist = models.ForeignKey('Artist', on_delete=models.CASCADE, related_name="songs", help_text="Artist who performed the song")
    album = models.ForeignKey('Album', on_delete=models.CASCADE, related_name="songs", help_text="Album where the song is included", null=True, blank=True)
    duration = models.DurationField(help_text="Duration of the song in HH:MM:SS format")
    release_date = models.DateField(help_text="Release date of the song", null=True, blank=True)
    file = models.FileField(upload_to='songs/', null=True, blank=True, help_text="Audio file of the song")  # Güncellenmiş alan

    def __str__(self):
        return self.title


class Playlist(models.Model):
    name = models.CharField(max_length=100, help_text="Name of the playlist")
    description = models.TextField(help_text="Description of the playlist", blank=True, null=True)
    songs = models.ManyToManyField(Song, related_name="playlists", help_text="Songs included in the playlist")
    created_at = models.DateTimeField(auto_now_add=True, help_text="Date and time when the playlist was created")

    def __str__(self):
        return self.name
    
class Album(models.Model):
    title = models.CharField(max_length=100, help_text="Title of the album")
    artist = models.ForeignKey(Artist, on_delete=models.CASCADE, related_name="albums", help_text="Artist who created the album")
    release_date = models.DateField(help_text="Release date of the album", null=True, blank=True)

    def __str__(self):
        return self.title
