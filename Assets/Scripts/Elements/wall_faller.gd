extends Sprite2D

@export var player: CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body == player:
	if body.name== "MainCharacter":
		print("player in")
		#body.velocity.x += (2*body.look_dir)
		body.change_state("in_air", body.state_access)
		#pass
