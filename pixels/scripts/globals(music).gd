extends Node2D
var theStream 
# WAIT!!!!!!!!!!!!!!!!!!!!
# This is my first time making a function with parameters by myself, barely any docs, no tutorials

# This function takes the scene and the scenes audio stream player as parameters to play the music that would correspond with the levels in the actual piece and also in the video I made :]
# Yay i did this all by myself and it worke

func change_scene_music(scene, audio: AudioStreamPlayer):
	match scene.name:
		"level_one":
			theStream = AudioStreamMP3.load_from_file("res://music/level1music.MP3")
		"level_two":
			theStream = AudioStreamMP3.load_from_file("res://music/level2audio.MP3")
		"boss_level":
			theStream = AudioStreamMP3.load_from_file("res://music/bosslevelmusic.MP3")
		"level_4":
			theStream = AudioStreamMP3.load_from_file("res://music/gohomemusic.MP3")
		"you_won":
			theStream = AudioStreamMP3.load_from_file("res://music/endmusic.MP3")
		"goals":
			theStream = AudioStreamMP3.load_from_file("res://music/goalsmusic.MP3")
		"leaving_home":
			theStream = AudioStreamMP3.load_from_file("res://music/leavehomemusic.MP3")
			
			audio.set_stream(theStream)
			audio.autoplay = true
			theStream.loop = true
			audio.play()
