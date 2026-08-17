extends Node2D
@export var target_level : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var _v1 = delta
	GameManager.lives = 3
	GameManager.num_hearts = 3
	await get_tree().create_timer(9.0).timeout
	get_tree().change_scene_to_packed(target_level)
