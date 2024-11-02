extends CharacterBody2D
@export var speed := 200

func _physics_process(delta):
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	#velocity.y += 200
	move_and_slide()
