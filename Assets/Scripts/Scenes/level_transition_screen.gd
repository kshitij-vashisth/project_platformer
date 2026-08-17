extends Node2D
@export var level_label: Label
@export var game_manager: Node
@export var lives_label: Label

func load_level(level_name: String) -> void:
	var path = "res://Assets/Scenes/Levels/%s.tscn" % level_name
	get_tree().change_scene_to_file(path)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if game_manager.level_index == 3 and game_manager.level_1_1_loaded == 0:
		#game_manager.level_1_1_loaded += 1
		#game_manager.reset_game_soft()
	lives_label.text = "X "+str(GameManager.lives)	
	level_label.text = str(GameManager.level_list[GameManager.level_index])
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var _v: float = delta
	await get_tree().create_timer(3).timeout
	load_level(GameManager.level_changer_list[GameManager.level_index])
