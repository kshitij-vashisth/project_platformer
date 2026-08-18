extends RichTextLabel
@export var player: CharacterBody2D
@export var current_state_label: RichTextLabel
@export var double_jump_switcher: Button
var text1: String

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta: float) -> void:
	#pass
	text1 = str(player.state_access.current_state)
	current_state_label.text = "State: "+text1.substr(0,text1.find(":"))


func _on_button_pressed() -> void:
	player.doubleJumpEnabled = !player.doubleJumpEnabled
	if player.doubleJumpEnabled:
		double_jump_switcher.text = "Double Jump: On"
	else:
		double_jump_switcher.text = "Double Jump: Off"
