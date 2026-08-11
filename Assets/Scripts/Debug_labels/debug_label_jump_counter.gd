extends RichTextLabel
@export var Player: CharacterBody2D
#@export var jump_counter_label: RichTextLabel
var jump_counter_label: RichTextLabel = self

func _physics_process(_delta: float) -> void:
	jump_counter_label.text = "Jump Count: "+str(Player.jump_count)
