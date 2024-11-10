extends State
class_name EnemyHit

@export var enemy: CharacterBody2D
@export var move_speed := 10.0

var move_direction :  Vector2
var wander_time: float
var player: CharacterBody2D
var animation_player
var Marker
var hitbox
@export var health := 2
var soul = preload("res://tscn/soul.tscn")

func Enter():
	print("enemy hit")
	enemy.velocity.x = 0
	player = get_tree().get_first_node_in_group("Player")
	animation_player = get_tree().get_first_node_in_group("animation")
	Marker = get_tree().get_first_node_in_group("soul_marker")
	hitbox = get_tree().get_first_node_in_group("enemy_hitbox")
	
	
	
	
	var direction = player.global_position - enemy.global_position
	health -= 1
	if health <= 0:
		death()
	else:
		animation_player.play("hit")
		await get_tree().create_timer(0.9).timeout
		if direction.length() < 200:
			#print("Go to Chase, Blake!!")
			Transitioned.emit(self, "EnemyFollow")
		else:
			Transitioned.emit(self, "EnemyIdle")

func death():
	animation_player.play("death")
	hitbox.disabled = true
	await get_tree().create_timer(1.1).timeout
	#enemy.queue_free()
	var soul_instance = soul.instantiate()
	soul_instance.global_position = Marker.global_position
	add_child(soul_instance)

func Physics_Update(delta: float):
	if GlobalScript.kill_enemy == true:
		enemy.queue_free()

