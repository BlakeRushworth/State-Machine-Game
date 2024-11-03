extends State
class_name PlayerAttack

@export_group("Speed Values")
@export var speed := 100.0
@export var player: CharacterBody2D
var animation_player
var cooldown := 1.6
var once = false

func Enter():
	print("attack")
	#print(once)
	player.velocity.x = 0
	animation_player = get_tree().get_first_node_in_group("animation_player")

func Physics_Update(_delta: float):
	animation_player.play("attack")
	await get_tree().create_timer(cooldown).timeout
	cooldown_done()


func cooldown_done():
	#print(once)
	#print("attack done")
	if Input.is_action_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "PlayerJump")
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			Transitioned.emit(self, "PlayerWalk")
	elif Input.is_action_pressed("attack"):
		Transitioned.emit(self, "PlayerAttack")
	else:
		Transitioned.emit(self, "PlayerIdle")

func Exit():
	once = false
