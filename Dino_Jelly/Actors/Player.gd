extends Actor

#this function is running every frame
func _physics_process(delta: float) -> void:
	
	var direction: = get_direction()
	velocity = calculating_movement(velocity, direction, speedLimit)
	
	#moving the actor /the move_and_slide function is giving back the new Vector2 of the Actor for each frame
	velocity = move_and_slide(velocity, Vector2.UP)


#calculating the direction: the Input.get_action_strength gives a float back between 0 and 1. When moving right direction=+1 when left direction=-1
#"move_left" and "move_right" are defined in Project->Project_Settings->Input_map
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 0.0)
		
func calculating_movement(linear_velocity: Vector2, direction: Vector2, speedLimit: Vector2) -> Vector2:
	var new_velocity:= linear_velocity
	new_velocity.x = speedLimit.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speedLimit.y * direction.y
	return new_velocity
	
	