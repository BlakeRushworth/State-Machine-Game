extends State
class_name Ranged_Enemy_Hit


@export var enemy: CharacterBody2D
@export var move_speed := 10.0

var move_direction :  Vector2
var wander_time: float
var player: CharacterBody2D
var animation_player
@export var health := 2

func Enter():
	health = GlobalScript.range_enemy_health
	print("ranged_enemy_hit")
	enemy.velocity.x = 0
	player = get_tree().get_first_node_in_group("Player")
	animation_player = get_tree().get_first_node_in_group("ranged_animation")
	
	var direction = player.global_position - enemy.global_position
	health -= 1
	GlobalScript.range_enemy_health = health
	if health <= 0:
		animation_player.play("death")
		await get_tree().create_timer(1.2).timeout
		enemy.queue_free()
	else:
		animation_player.play("hit")
		await get_tree().create_timer(0.9).timeout
		if direction.length() < 200:
			#print("Go to Chase, Blake!!")
			Transitioned.emit(self, "Walk")
		else:
			Transitioned.emit(self, "Idle")
