extends CharacterBody2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
		if (Input.is_action_just_pressed("pound")):
			velocity.y = 1500.0
	elif (Input.is_action_just_pressed("jump")):
		velocity.y = -700.0

	var input_direction = Input.get_axis("move_left", "move_right")
	if input_direction:
		velocity.x = input_direction * 400.0
	else:
		velocity.x = move_toward(velocity.x, 0., 100)
	
	move_and_slide()
