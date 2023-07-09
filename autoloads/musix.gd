extends Node


@export var main_theme : AudioStream
@export var game_over : AudioStream
@export var in_game : AudioStream



var current_song
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func play(song, from_position = 0.0, volume_db = 0.0):
	audio_stream_player.stream = song
	audio_stream_player.volume_db = volume_db
	audio_stream_player.play(from_position)

func fade(duration = 1.0):
	var pre_volume_db = audio_stream_player.volume_db
	var volume_fade = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	volume_fade.tween_property(audio_stream_player, "volume_db", -50.0, duration)
	await volume_fade.finished
	audio_stream_player.stop()
	audio_stream_player.volume_db = pre_volume_db


