extends State
class_name PlayerAttack

@export_group("Speed Values")
@export var speed := 100.0
@export var player: CharacterBody2D


var arrow = preload("res://tscn/arrow.tscn")

var Marker2d
var animation_player
var healthbar
var cooldown := 1.6


func Enter():
	player.attack_animation = true
	print("player_attack_enter")
	player.velocity.x = 0
	animation_player = get_tree().get_first_node_in_group("animation_player")
	Marker2d = get_tree().get_first_node_in_group("marker")
	
	animation_player.play("attack")
	await get_tree().create_timer(cooldown/2).timeout
	shoot()
	await get_tree().create_timer(cooldown/2).timeout
	cooldown_done()



func cooldown_done():
	Transitioned.emit(self, "PlayerNone")

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
	print("player_attack_exit")
