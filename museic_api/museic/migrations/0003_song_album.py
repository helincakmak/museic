# Generated by Django 5.1 on 2024-09-02 13:11

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('museic', '0002_album'),
    ]

    operations = [
        migrations.AddField(
            model_name='song',
            name='album',
            field=models.ForeignKey(blank=True, help_text='Album where the song is included', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='songs', to='museic.album'),
        ),
    ]
