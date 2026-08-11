extends RichTextLabel
@export var Player: CharacterBody2D

var look_dir_checker_label: RichTextLabel = self

func _physics_process(_delta: float) -> void:
	look_dir_checker_label.text = "Look Dir: "+str(Player.look_dir)
