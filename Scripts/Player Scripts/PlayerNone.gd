extends State
class_name PlayerNone

@export var player: CharacterBody2D

func Physics_Update(delta: float):
	player.attack_animation = false
	#print("attack false")
	if Input.is_action_pressed("attack"):
		print("attack")
		Transitioned.emit(self, "PlayerAttack")
