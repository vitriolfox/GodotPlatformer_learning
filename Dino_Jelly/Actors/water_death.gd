extends "res://Actors/black_jelly.gd"


func _on_stomp_detectorArea2D_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("stomp_detector-Area2D").global_position.y:
		return
	get_node("CollisionShape2D").disabled
	queue_free()