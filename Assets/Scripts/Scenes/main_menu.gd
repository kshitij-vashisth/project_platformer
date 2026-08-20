extends Node
#Buttons========================================>
@onready var load_game: Button = $Continue
@export var start_game: Button
@export var exit_game: Button
@export var tile_map: TileMapLayer
@export var mushroom: CharacterBody2D
@onready var logo: AnimatedSprite2D = $logo
@export var bg: ParallaxBackground
@export var black_box: ColorRect
@export var text_panel: Panel
@export var next_button: Button
#===============================================>


func _ready() -> void:
	#if !GameManager.save_file_exists():
		#load_game.disabled = true  
	load_game.disabled = true  
	
#func load_level(level_name: String) -> void:
	#var path = "res://assets/Scenes/levels/%s.tscn" % level_name
	#get_tree().change_scene_to_file(path)

#func _on_level_1_pressed() -> void:
	#if !GameManager.first_load:
		#get_tree().change_scene_to_file("res://assets/Scenes/Levels/Level_0-1.tscn")
		#GameManager.first_load = true
	#else:
		#get_tree().change_scene_to_file("res://assets/Scenes/levels/LevelTransitionScreen.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()


#func _on_continue_pressed() -> void:
	#GameManager.load_from_file()
	#get_tree().change_scene_to_file("res://assets/Scenes/levels/LevelTransitionScreen.tscn")

func _on_start_pressed() -> void:
	#get_tree().change_scene_to_file("res://Assets/Scenes/Levels/Level_0-1.tscn")
	#get_tree().change_scene_to_file("res://Assets/Scenes/TransitionScreens/level_transition_screen.tscn")
	start_game.hide()
	load_game.hide()
	exit_game.hide()
	await get_tree().create_timer(3.0).timeout
	mushroom.queue_free()
	logo.queue_free()
	tile_map.hide()
	black_box.show()
	text_panel.show()
	bg.hide()
	
	#get_tree().change_scene_to_file("res://Assets/Scenes/Cutscenes/Intro.tscn")
	Anima.begin_single_shot(self) \
	.then(Anima.Node($Intro_elements/Panel).anima_scale_y(1.0, 0.3).anima_from(0)) \
	.then(Anima.Node($Intro_elements/Panel/Label).anima_animation('typewrite', 0.03) ) \
	.then(Anima.Node($Intro_elements/Panel/Begin).anima_animation('fade in', 2.0) ) \
	.set_visibility_strategy(ANIMA.VISIBILITY.TRANSPARENT_ONLY) \
	.play_with_delay(0.5)
	
	


func _on_begin_pressed() -> void:
	var anima = Anima.begin(self, 'fade_out')
	anima.with({ node = text_panel, animation = 'fadeOut', duration = 1.4})
	anima.play()
	await get_tree().create_timer(2.0).timeout
	text_panel.queue_free()
	get_tree().change_scene_to_file("res://Assets/Scenes/Cutscenes/Intro.tscn")
