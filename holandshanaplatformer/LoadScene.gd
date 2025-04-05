extends Node2D

func _input(event):
	if(event.is_action_pressed("move_left") || event.is_action_pressed("move_right")):
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
