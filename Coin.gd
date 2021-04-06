extends Area


func _physics_process(delta):
	rotation.y += delta
	

	

func _on_Coin_body_entered(body):
	if body.name == "Ball":
		body.get_parent().add_coin()
		queue_free()
