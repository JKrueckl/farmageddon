extends Node2D
const BUNNY_S_WRATH = preload("res://sound/music/Bunny's Wrath.mp3")
const CARROT_SUNRISE = preload("res://sound/music/Carrot Sunrise.mp3")
const THE_KILLER_BUNNY_AND_CARROTS = preload("res://sound/music/The Killer Bunny and Carrots.mp3")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var music_playlist = [BUNNY_S_WRATH, CARROT_SUNRISE, THE_KILLER_BUNNY_AND_CARROTS]
var music_playlist_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_audio_stream_player_2d_finished() -> void:
	music_playlist_index += 1
	if music_playlist_index > len(music_playlist):
		music_playlist_index = 0
	audio_stream_player_2d.stream = music_playlist[music_playlist_index]
	audio_stream_player_2d.play()
