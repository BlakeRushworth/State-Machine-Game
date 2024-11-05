extends CharacterBody2D
@export var speed := 200

var dir : String = "right"
var immune = false
var touching_enemy = false



func _physics_process(delta):
	if velocity.x < 0 and dir == "right":
		$Sprite2D.flip_h = true
		dir = "left"
		print("dir",dir)
	elif velocity.x > 0 and dir == "left":
		$Sprite2D.flip_h = false
		dir = "right"
		print("dir",dir)

	check_hit()
	move_and_slide()


func check_hit():
	if touching_enemy == true and immune == false:
		immune = true
		$CanvasLayer/TextureProgressBar.value -= 10
		if $CanvasLayer/TextureProgressBar.value < 27:
			print("dead")
			dead()
		await get_tree().create_timer(2).timeout
		immune = false

func dead():
	pass

func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy"):
		print("player hit")
		touching_enemy = true



func _on_hitbox_area_exited(area):
	if area.is_in_group("enemy"):
		print("player hit")
		touching_enemy = false
