extends "res://Actors/Actor.gd"


func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed_limit.x


func _physics_process(delta: float) -> void:
	get_node("Jelly (6)/AnimationPlayer").play("wobbling")
	velocity.y += gravity * delta
	
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity, Vector2.UP).y
		


func _on_stomp_detectorArea2D_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("stomp_detector-Area2D").global_position.y:
		return
	get_node("CollisionShape2D").disabled
	queue_free()
