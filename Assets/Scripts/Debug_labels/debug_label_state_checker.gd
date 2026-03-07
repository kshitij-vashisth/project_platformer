extends RichTextLabel
@export var Player: CharacterBody2D
@export var current_state_label: RichTextLabel
var text1: String

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	text1 = str(Player.state_access.current_state)
	current_state_label.text = "State: "+text1.substr(0,text1.find(":"))
