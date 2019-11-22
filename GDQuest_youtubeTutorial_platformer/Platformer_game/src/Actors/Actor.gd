extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP
export var speed: = Vector2(300, 1000)
export var gravity: = 3000.0
var velocity: = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta

	