extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene

func _get_configuration_warning() -> String:
	return "next_scene field can't be empty" if not next_scene else ""

func teleport() -> void:
	anim_player.play("Fade_in")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)

func _on_NextLevel_body_entered(body: PhysicsBody2D) -> void:
	teleport()
