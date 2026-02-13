extends Node

var theStream 
# WAIT!!!!!!!!!!!!!!!!!!!!
# This is my first time making a function with parameters by myself, barely any docs, no tutorials

# This function takes the scene and the scenes audio stream player as parameters to play the music that would correspond with the levels in the actual piece and also in the video I made :]
# Yay i did this all by myself and it worke

# It actually took me like 45 minutes to get this to actually work after writing the above comments
# I actually forgot to remove the level 1 music from the scene's audio stream player, and no error messages were thrown so I thought I was good
# lol :skull:
# still "barely any docs" and "no tutorials" still stands, but I'll add the docs/ forum posts I DID use to the readme now
# I probably don't have to but i do like doing it
func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound
	
	
func change_scene_music(scene, audio: AudioStreamPlayer):
	match scene.name:
		"level_one":
			var enter = load_mp3("res://music/levelone.MP3")
			theStream = AudioStreamMP3.load_from_buffer(enter)
		"level_two":
			theStream = AudioStreamMP3.load_from_file("res://music/level2audio.MP3")
		"boss_level":
			theStream = AudioStreamMP3.load_from_file("res://music/bosslevelmusic.MP3")
		"level_four":
			theStream = AudioStreamMP3.load_from_file("res://music/gohomemusic.MP3")
		"you_won":
			theStream = AudioStreamMP3.load_from_file("res://music/endmusic.MP3")
		"goals":
			theStream = AudioStreamMP3.load_from_file("res://music/goalsmusic.MP3")
		"leaving_homey":
			theStream = AudioStreamMP3.load_from_file("res://music/leavehomemusic.MP3")
			
	audio.set_stream(theStream)
	audio.autoplay = true
	audio.play()
