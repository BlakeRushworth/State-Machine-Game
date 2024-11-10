extends State
class_name PlayerFall

@export_group("Speed Values")
@export var speed := 100.0
@export var player: CharacterBody2D


@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float
@export var amin_speed : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
var animation_player

func fall():
	player.velocity.y = fall_gravity

func Enter():
	print("player_fall_enter")
	animation_player = get_tree().get_first_node_in_group("animation_player")

func Physics_Update(delta: float):
	if player.attack_animation == false:
		animation_player.play("falling")
	player.velocity.y += fall_gravity * delta
	
	var direction = Input.get_vector("move_left","move_right","none","none").normalized()
	player.velocity.x = direction.x * speed
	if GlobalScript.player_dead == true:
		Transitioned.emit(self, "PlayerDeath")
	elif player.is_on_floor():
		if player.velocity.x != 0:
			Transitioned.emit(self, "PlayerWalk")
		else:
			Transitioned.emit(self, "PlayerIdle")

func Exit():
	print("player_fall_exit")
