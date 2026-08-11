extends RichTextLabel
@export var Player: CharacterBody2D

var on_wall_checker_label: RichTextLabel = self

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta: float) -> void:
	if Player.is_on_wall_only():
		on_wall_checker_label.text = "On Wall: Yes"
		#print("player: on wall")
	else:
		on_wall_checker_label.text = "On Wall: No"
		#print("player: not on wall")
