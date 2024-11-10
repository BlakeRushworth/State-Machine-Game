extends State
class_name PlayerDeath

@export var player: CharacterBody2D
var animation_player


func Enter():
	print("player_death_enter")
	player.velocity = Vector2()
	animation_player = get_tree().get_first_node_in_group("animation_player")
	animation_player.play("death")
	await get_tree().create_timer(1.8).timeout
	GlobalScript.death_screen = true

func Physics_Update(_delta: float):
	pass
