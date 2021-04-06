extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_Level_1_pressed():
	get_tree().change_scene("res://Level 1.tscn")


func _on_Level_2_pressed():
	get_tree().change_scene("res://Level 2.tscn")
