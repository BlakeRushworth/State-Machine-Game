extends State
class_name PlayerWalk

@export_group("Speed Values")
@export var speed := 100.0
@export var player: CharacterBody2D
var animation_player

func Enter():
	print("walk")
	animation_player = get_tree().get_first_node_in_group("animation_player")
	#print(animation_player)

func Physics_Update(delta: float):
	animation_player.play("walk")
	var direction = Input.get_vector("move_left","move_right","none","none").normalized()
	player.velocity = direction * speed
	
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "PlayerAttack")
	elif (Input.is_action_just_pressed("jump") and player.is_on_floor()):
		Transitioned.emit(self, "PlayerJump")
	elif player.is_on_floor() == false:
		Transitioned.emit(self, "PlayerFall")
	elif player.velocity == Vector2():
		Transitioned.emit(self, "PLayerIdle")
