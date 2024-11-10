extends State
class_name Ranged_Enemy_Idle

@export var enemy: CharacterBody2D
@export var move_speed := 10.0
@export var gravity := 200

var move_direction :  Vector2
var wander_time: float
var wait: int
var player: CharacterBody2D
var animation_player
var soul

func randomise_wander():
	move_direction = Vector2(randf_range(-1,1), 0).normalized()
	wander_time = randf_range(3,5)
	wait = randf_range(0,1)

func Enter():
	#print("ranged enemy idle")
	randomise_wander()
	player = get_tree().get_first_node_in_group("Player")
	animation_player = get_tree().get_first_node_in_group("ranged_animation")
	soul = get_tree().get_first_node_in_group("soul")

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	
	else:
		randomise_wander()

func Physics_Update(delta: float):
	animation_player.play("idle")
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	if soul:
		var dir_to_soul = soul.global_position - enemy.global_position
		#print(dir_to_soul)
		if dir_to_soul.length() < 50:
			print("soul close")
			Transitioned.emit(self, "Get_Soul")
	
	var direction = player.global_position - enemy.global_position
	if direction.length() < 200:
		Transitioned.emit(self, "Walk")


func _on_hitbox_area_entered(area):
	if area.is_in_group("arrow"):
		Transitioned.emit(self, "Hit")


