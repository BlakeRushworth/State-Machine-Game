extends Area2D

func _physics_process(delta):
	$AnimationPlayer.play("spinning")



func _on_area_entered(area):
	if area.is_in_group("ranged_enemy"):
		$".".visible = false
		$CollisionShape2D.disabled = true
		#queue_free()
