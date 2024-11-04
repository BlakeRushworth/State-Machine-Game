extends CharacterBody2D
@export var speed := 200
var dir : String = "right"

func _physics_process(delta):
	if velocity.x < 0 and dir == "right":
		$Sprite2D.flip_h = true
		dir = "left"
		print("dir",dir)
	elif velocity.x > 0 and dir == "left":
		$Sprite2D.flip_h = false
		dir = "right"
		print("dir",dir)
	
	#velocity.y += 200
	move_and_slide()
