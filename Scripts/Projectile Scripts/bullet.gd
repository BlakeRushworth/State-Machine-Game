extends Area2D

var speed = 500

func _ready():
	set_as_top_level(true)

func _process(delta):
	position += (Vector2.RIGHT * speed).rotated(rotation) * delta



func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()




func _on_area_entered(area):
	if area.is_in_group("Player"):
		queue_free()
