extends Node

@onready var continue1: Button = $Continue

func _ready() -> void:
	#if !GameManager.save_file_exists():
		#continue1.disabled = true  
	continue1.disabled = true  
	
func load_level(level_name: String) -> void:
	var path = "res://assets/Scenes/levels/%s.tscn" % level_name
	get_tree().change_scene_to_file(path)

func _on_level_1_pressed() -> void:
	if !GameManager.first_load:
		get_tree().change_scene_to_file("res://assets/Scenes/Levels/Level_0-1.tscn")
		GameManager.first_load = true
	else:
		get_tree().change_scene_to_file("res://assets/Scenes/levels/LevelTransitionScreen.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


#func _on_continue_pressed() -> void:
	#GameManager.load_from_file()
	#get_tree().change_scene_to_file("res://assets/Scenes/levels/LevelTransitionScreen.tscn")
