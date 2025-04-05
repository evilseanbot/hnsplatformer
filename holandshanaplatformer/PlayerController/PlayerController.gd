extends CharacterBody2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	
	var input_direction = Input.get_axis("move_left", "move_right")
	if input_direction:
		velocity.x = input_direction * 300.0
	else:
		velocity.x = move_toward(velocity.x, 0., 300)
	
	move_and_slide()
