extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 10.0

var move_direction :  Vector2
var wander_time: float
var player: CharacterBody2D

func randomise_wander():
	move_direction = Vector2(randf_range(-1,1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1,3)
	
func Enter():
	randomise_wander()
	player = get_tree().get_first_node_in_group("Player")
	
func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	
	else:
		randomise_wander()

func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	var direction = player.global_position - enemy.global_position
	#print(float(direction.length()))
	
	if direction.length() < 200:
		#print("Go to Chase, Blake!!")
		Transitioned.emit(self, "EnemyFollow")
	