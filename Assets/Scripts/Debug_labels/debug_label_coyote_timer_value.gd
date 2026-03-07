extends RichTextLabel
@export var Player: CharacterBody2D
@onready var timer_import: Timer = $"/root/Node/MainCharacter/Timer_Nodes/Coyote_Timer"
#@export var timer_import : Timer
var coyote_time_value: RichTextLabel = self


	
func _physics_process(delta: float) -> void:
	coyote_time_value.text = "Coyote Value: %.2f" % abs(timer_import.wait_time)
	#print(velocity_checker.text)
	#pass
