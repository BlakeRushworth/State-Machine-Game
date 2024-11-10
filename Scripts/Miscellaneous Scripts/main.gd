extends Node2D

var CorrectSound = preload("res://music/video-game-boss-fiight-259885.mp3")

func _physics_process(delta):
	if !$AudioStreamPlayer.is_playing():
			$AudioStreamPlayer.stream = CorrectSound
			$AudioStreamPlayer.play()
