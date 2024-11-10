extends State
class_name Get_Soul


@export var enemy: CharacterBody2D
@export var move_speed :=60.0
var soul
var player
var direction

func Enter():
	print("soul entered")
	soul = get_tree().get_first_node_in_group("soul")
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	print("soul finding")
	var dir_to_soul = soul.global_position - enemy.global_position
	enemy.velocity = dir_to_soul * move_speed
	direction = player.global_position - enemy.global_position


func _on_hitbox_area_entered(area):
	if area.is_in_group("arrow"):
		print("arrow hit")
		Transitioned.emit(self, "Hit")
	elif area.is_in_group("soul"):
		print("soul grabbed")
		await get_tree().create_timer(0.2).timeout
		Transitioned.emit(self, "Idle")
	else:
		print("unknown hit")
