extends State
class_name Ranged_Enemy_Walk

@export var enemy: CharacterBody2D
@export var move_speed :=60.0
@export var min_dist := 40.0
@export var max_dist := 50.0

var animation_player
var player: CharacterBody2D
var soul

func Enter():
	print("ranged_enemy_walk")
	player = get_tree().get_first_node_in_group("Player")
	animation_player = get_tree().get_first_node_in_group("ranged_animation")
	soul = get_tree().get_first_node_in_group("soul")

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	
	
	if GlobalScript.am_visible == true and soul:
		var dir_to_soul = soul.global_position - enemy.global_position
		if dir_to_soul.length() < 100:
			print("soul close")
			Transitioned.emit(self, "Get_Soul")
	
	
	if direction.length() < min_dist:
		direction.x *= -1
		enemy.velocity = direction.normalized() * move_speed
		animation_player.play("walk")
		#print("walking")
	elif direction.length() > max_dist:
		#direction.x *= -1
		enemy.velocity = direction.normalized() * move_speed
		animation_player.play("walk")
	else:
		enemy.velocity = Vector2()
		Transitioned.emit(self, "Shoot")
	
	if direction.length() > 250:
		#print("Go to Idle, Blake!!")
		Transitioned.emit(self, "Idle")



func _on_hitbox_area_entered(area):
	if area.is_in_group("arrow"):
		Transitioned.emit(self, "Hit")

