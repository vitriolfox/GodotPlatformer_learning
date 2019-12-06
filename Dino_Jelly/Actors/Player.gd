extends Actor

export var stomp_recoil: = 1000.0


#this function is running every frame
func _physics_process(delta: float) -> void:
	var is_flipped: = bool(get_node("AnimatedSprite").flip_h)
	var position: = Vector2(get_node("CollisionShape2D").get_global_position().x,get_node("CollisionShape2D").get_global_position().y)
	#if is_flipped:
	#	position.x = get_node("AnimatedSprite").get_global_position().x + 39
	#else:
	#	position.x = get_node("AnimatedSprite").get_global_position().x - 39
	if Input.is_action_pressed("move_right"):
		get_node("AnimatedSprite").flip_h = false
		if Input.is_action_just_pressed("move_right"):
			position.x = get_node("AnimatedSprite").get_global_position().x - 25
			get_node("CollisionShape2D").set_global_position(position)
			get_node("EnemyDetector").set_global_position(position)
		$AnimatedSprite.play("run")
	if Input.is_action_pressed("move_left"):
		get_node("AnimatedSprite").flip_h = true
		if Input.is_action_just_pressed("move_left"):
			position.x = get_node("AnimatedSprite").get_global_position().x + 25
			get_node("CollisionShape2D").set_global_position(position)
			get_node("EnemyDetector").set_global_position(position)
		$AnimatedSprite.play("run")
	if Input.is_action_pressed("jump"):
		$AnimatedSprite.play("jump")
	if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left") or Input.is_action_just_released("jump"):
		$AnimatedSprite.play("idle")
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculating_movement(velocity, direction, speed_limit, is_jump_interrupted)
	
	#moving the actor /the move_and_slide function is giving back the new Vector2 of the Actor for each frame
	velocity = move_and_slide(velocity, Vector2.UP)


#calculating the direction: the Input.get_action_strength gives a float back between 0 and 1. When moving right direction=+1 when left direction=-1
#"move_left" and "move_right" are defined in Project->Project_Settings->Input_map
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 0.0)
		
func calculating_movement(linear_velocity: Vector2, direction: Vector2, speed_limit: Vector2, is_jump_interrupted: bool) -> Vector2:
	var new_velocity:= linear_velocity
	new_velocity.x = speed_limit.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed_limit.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity
	
func calculating_stomp_jump(linear_velocity: Vector2, stomp_recoil: float) -> Vector2:
	var jump_velocity = linear_velocity
	jump_velocity.y = -stomp_recoil
	return jump_velocity

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	velocity = calculating_stomp_jump(velocity, stomp_recoil)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	$AnimatedSprite.play("dead")
	queue_free()
