extends Node




var sounds_path = "res://sound/"


@export var explode : AudioStream
@export var footstep : AudioStream
@export var jump : AudioStream
@export var swing : AudioStream
@export var click : AudioStream
@export var die : AudioStream
@export var hurt : AudioStream



@onready var sound_players = get_children()


func play(sound_stream, pitch_scale = 1.0, volume_db = 0.0):
	for sound_player in sound_players:
		if !sound_player.playing:
			sound_player.pitch_scale = pitch_scale
			sound_player.volume_db = volume_db
			sound_player.stream = sound_stream
			sound_player.play()
			return
	print_debug("too many")
