extends CharacterBody2D

var last_velocity = Vector2(0,0)
var was_on_floor = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta * 5
		if (Input.is_action_pressed("pound")):
			velocity.y = 3000.0
	elif (Input.is_action_just_pressed("jump")):
		velocity.y = -1200.0



	var input_direction = Input.get_axis("move_left", "move_right")
	if input_direction:
		velocity.x = move_toward(velocity.x, input_direction * 400, 50)
	else:
		velocity.x = move_toward(velocity.x, 0., 40)
		
	if Input.is_action_just_pressed("dash"):
		velocity.x += input_direction * 1500
		
	if not was_on_floor and is_on_floor():
		var space_state = get_world_2d().direct_space_state
		# use global coordinates, not local to node
		var position_left = position + Vector2(-1, 0)
		var query_left = PhysicsRayQueryParameters2D.create(position_left, position_left + Vector2(0, 100))
		var result_left = space_state.intersect_ray(query_left)
		var position_right = position + Vector2(1, 0)
		var query_right = PhysicsRayQueryParameters2D.create(position_right, position_right + Vector2(0, 100))
		var result_right = space_state.intersect_ray(query_right)
		if result_left.has("position") and result_right.has("position"):
			var hit_left = result_left["position"]
			var hit_right = result_right["position"]
			var dx = hit_left.x - hit_right.x
			var dy = hit_left.y - hit_right.y
			var normal = Vector2(-dy, dx).normalized()
			print(normal)
			if normal.y != -1:	
				var dir = 1 if dy > 0 else -1
				var tangent = Vector2(dir * normal.y, dir * -1 * normal.x)
				var force = 1 * max(0, last_velocity.y - gravity)
				velocity += tangent * force
	
	was_on_floor = is_on_floor()
	last_velocity = velocity
	
	move_and_slide()
