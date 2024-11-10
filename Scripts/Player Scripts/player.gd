extends CharacterBody2D
@export var speed := 200

var dir : String = "right"
var immune = false
var touching_enemy = false

var attack_animation = false

func _ready():
	pass

func _physics_process(delta):
	if velocity.x < 0 and dir == "right":
		$Sprite2D.flip_h = true
		dir = "left"
		#print("dir",dir)
	elif velocity.x > 0 and dir == "left":
		$Sprite2D.flip_h = false
		dir = "right"
		#print("dir",dir)
	
	if GlobalScript.death_screen == true:
		$"Hitbox/Death Screen".visible = true
	move_and_slide()


func dead():
	GlobalScript.player_dead = true

func _on_hitbox_area_entered(area):
	if area.is_in_group("damage"):
		print("player hit")
		if immune == false:
			immune = true
		$CanvasLayer/TextureProgressBar.value -= 10
		if $CanvasLayer/TextureProgressBar.value < 27:
			print("dead")
			dead()
		await get_tree().create_timer(2).timeout
		immune = false




func _on_button_pressed():
	get_tree().change_scene_to_file("res://tscn/main_menu.tscn")
