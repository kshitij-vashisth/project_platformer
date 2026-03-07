extends RichTextLabel
@export var Player: CharacterBody2D

var velocity_checker: RichTextLabel = self

func _physics_process(delta: float) -> void:
	velocity_checker.text = "Velocity: %.2f" % abs(Player.velocity.x)
	#print(velocity_checker.text)
