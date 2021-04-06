extends Area

export(String, FILE) var scene

func _on_LevelTransition_body_entered(body):
	if body.name == "Ball":
		get_tree().change_scene(scene)
