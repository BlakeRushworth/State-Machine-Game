extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 10.0
@export var gravity := 200

var move_direction :  Vector2
var wander_time: float
var wait: int
var player: CharacterBody2D
var animation_player


func randomise_wander():
	move_direction = Vector2(randf_range(-1,1), 0).normalized()
	wander_time = randf_range(3,5)
	wait = randf_range(0,1)

func Enter():
	print("enemy idle")
	randomise_wander()
	player = get_tree().get_first_node_in_group("Player")
	animation_player = get_tree().get_first_node_in_group("animation")

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomise_wander()

func Physics_Update(delta: float):
	animation_player.play("idle")
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	var direction = player.global_position - enemy.global_position
	#print(float(direction.length()))
	if direction.length() < 200:
		#print("Go to Chase, Blake!!")
		Transitioned.emit(self, "EnemyFollow")



func _on_hitbox_area_entered(area):
	print("hit")
	if area.is_in_group("arrow"):
		#print("was arrow")
		Transitioned.emit(self, "EnemyHit")
