extends State
class_name PlayerJump

@export_group("Speed Values")
@export var speed := 100.0
@export var player: CharacterBody2D

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
var animation_player
var y_dir : String


func get_gravity(): 
	if player.velocity.y <0.0:
		return jump_gravity 
		y_dir = "up"
	else:
		return fall_gravity
		y_dir = "down"



func jump():
	player.velocity.y = jump_velocity


func Enter():
	print("jump")
	jump()
	animation_player = get_tree().get_first_node_in_group("animation_player")




func Physics_Update(_delta: float):
	player.velocity.y += get_gravity() * _delta
	
	var direction = Input.get_vector("move_left","move_right","none","none").normalized()
	player.velocity.x = direction.x * speed
	
	
	if y_dir == "up":
		animation_player.play("jumping")
	else:
		animation_player.play("falling")
	
	if player.is_on_floor():
		if player.velocity.x != 0:
			Transitioned.emit(self, "PlayerWalk")
		else:
			Transitioned.emit(self, "PlayerIdle")
