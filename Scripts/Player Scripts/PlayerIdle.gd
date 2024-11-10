extends State
class_name PlayerIdle

@export_group("Speed Values")
@export var speed := 100.0
@export var player: CharacterBody2D
var animation_player


func Enter():
	print("player_idle_enter")
	player.velocity = Vector2()
	animation_player = get_tree().get_first_node_in_group("animation_player")

func Physics_Update(_delta: float):
	if player.attack_animation == false:
		animation_player.play("idle")
	if GlobalScript.player_dead == true:
		Transitioned.emit(self, "PlayerDeath")
	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "PlayerJump")
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			Transitioned.emit(self, "PlayerWalk")
	
func Exit():
	print("player_idle_exit")
