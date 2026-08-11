extends RichTextLabel
@export var Player: CharacterBody2D
#@export var is_left_label: RichTextLabel
var is_left_label: RichTextLabel = self

func _physics_process(_delta: float) -> void:
	is_left_label.text = "IsLeft: "+str(Player.isLeft)
