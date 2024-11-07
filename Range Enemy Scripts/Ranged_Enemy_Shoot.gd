extends State
class_name Ranged_Enemy_Shoot
@export var enemy: CharacterBody2D

var player
var animation_player
var Marker2d
var bullet = preload("res://tscn/bullet.tscn")



func Enter():
	enemy.velocity = Vector2()
	player = get_tree().get_first_node_in_group("Player")
	animation_player = get_tree().get_first_node_in_group("ranged_animation")
	Marker2d = get_tree().get_first_node_in_group("enemy_marker")
	
	animation_player.play("shoot")
	await get_tree().create_timer(0.5).timeout
	shoot()
	await get_tree().create_timer(0.5).timeout
	#animation_player.play("idle")
	await get_tree().create_timer(0.5).timeout
	cooldown_done()

func shoot():
	var bullet_dir
	if enemy.dir == "right":
		bullet_dir = Vector2(player.global_position.x + (1*10**6), player.global_position.y)
		Marker2d.look_at(bullet_dir)
	else:
		bullet_dir = Vector2(player.global_position.x - (1*10**6), player.global_position.y)
		Marker2d.look_at(bullet_dir)
	#print(player.global_position)
	#print(arrow_dir)
	var bullet_instance = bullet.instantiate()
	bullet_instance.rotation = Marker2d.rotation
	bullet_instance.global_position = Marker2d.global_position
	add_child(bullet_instance)

func cooldown_done():
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 250:
		#print("Go to Idle, Blake!!")
		Transitioned.emit(self, "Idle")
	else:
		Transitioned.emit(self, "Walk")




func _on_hitbox_area_entered(area):
	if area.is_in_group("arrow"):
		Transitioned.emit(self, "Hit")
