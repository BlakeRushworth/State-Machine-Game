extends State
class_name Get_Soul


@export var enemy: CharacterBody2D
@export var move_speed := 10.0
var soul
var player
var direction

func Enter():
	print("ranged_enemy_soul")
	print(get_tree().get_nodes_in_group("soul"))
	soul = get_tree().get_first_node_in_group("soul")
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	#print("soul finding")
	var dir_to_soul = soul.global_position - enemy.global_position
	enemy.velocity = dir_to_soul * move_speed
	direction = player.global_position - enemy.global_position
	if soul.global_position == enemy.global_position:
		print("same spot")
		Transitioned.emit(self, "Idle")

func _on_hitbox_area_entered(area):
	if area.is_in_group("arrow"):
		print("arrow hit")
		Transitioned.emit(self, "Hit")
	elif area.is_in_group("soul"):
		print("soul grabbed")
		GlobalScript.range_enemy_health += 3
		GlobalScript.kill_enemy = true
		Transitioned.emit(self, "Idle")
	else:
		print("unknown hit")
