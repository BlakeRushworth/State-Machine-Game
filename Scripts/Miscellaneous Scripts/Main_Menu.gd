extends Control


func _on_button_pressed():
	pass # Replace with function body.


func _on_start_pressed():
	GlobalScript.death_screen = false
	GlobalScript.player_dead = false
	get_tree().change_scene_to_file("res://tscn/main.tscn")

func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://tscn/tutorial.tscn")





func _on_quit_pressed():
	get_tree().quit()
