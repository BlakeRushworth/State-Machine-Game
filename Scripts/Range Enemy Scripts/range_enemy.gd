extends CharacterBody2D

@export var enemy : CharacterBody2D
var dir := "right"
var player

func _physics_process(delta):
	player = get_tree().get_first_node_in_group("Player")
	var direction = player.global_position - enemy.global_position
	#print(direction)
	if direction.x < 0:
		$Sprite2D.flip_h = true
		dir = "left"
		#print("dir",dir)
	else:
		$Sprite2D.flip_h = false
		dir = "right"
		#print("dir",dir)
	
	velocity.y = 200
	#print(velocity)
	move_and_slide()

