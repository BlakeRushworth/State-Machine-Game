extends State
class_name PlayerAttack

@export_group("Speed Values")
@export var speed := 100.0
@export var player: CharacterBody2D

var bow_equipped = true
var bow_cooldown = true
var arrow = preload("res://tscn/arrow.tscn")

var Marker2d
var animation_player
var healthbar
var cooldown := 1.6
var once = false

func Enter():
	#print("attack")
	#print(once)
	player.velocity.x = 0
	animation_player = get_tree().get_first_node_in_group("animation_player")
	Marker2d = get_tree().get_first_node_in_group("marker")
	
	animation_player.play("attack")
	await get_tree().create_timer(cooldown/2).timeout
	shoot()
	await get_tree().create_timer(cooldown/2).timeout
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

func shoot():
	var arrow_dir
	if player.dir == "right":
		arrow_dir = Vector2(player.global_position.x+ (1*10**6), player.global_position.y)
		Marker2d.look_at(arrow_dir)
	else:
		arrow_dir = Vector2(player.global_position.x- (1*10**6), player.global_position.y)
		Marker2d.look_at(arrow_dir)
	#print(player.global_position)
	#print(arrow_dir)
	var arrow_instance = arrow.instantiate()
	arrow_instance.rotation = Marker2d.rotation
	arrow_instance.global_position = Marker2d.global_position
	add_child(arrow_instance)


func Exit():
	once = false
