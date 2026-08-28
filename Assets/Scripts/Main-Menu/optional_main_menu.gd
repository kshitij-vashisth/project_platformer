extends Node2D
@export var size_multiplier: float = 1.5
@export var gap_time: float = 0.5
@export var punch: Sprite2D
@export var main_logo: Sprite2D
@export var japan_logo: Sprite2D
@export var star: AnimatedSprite2D
@export var intro_node: Node
@export var text_panel: Panel
@export var next_button: Button
@export var music: AudioStreamPlayer2D
@export var start_button: Button
@export var load_button: Button
@export var exit_button: Button
@export var chunk: float = 10.0


var turnOffMusic: bool = false
func turn_off_volume(delta: float, chunk: float)-> void:
	if music.volume_db > -60.0:
			music.volume_db -= chunk * delta

func punch_animation(gap_time: float, size_multiplier: float)-> void:
	punch.show()
	await get_tree().create_timer(gap_time).timeout
	punch.scale = Vector2(size_multiplier, size_multiplier)
	await get_tree().create_timer(gap_time).timeout
	punch.scale = Vector2(size_multiplier ** 2, size_multiplier ** 2)
	await get_tree().create_timer(gap_time).timeout
	punch.scale = Vector2(size_multiplier ** 3, size_multiplier ** 3)

func logo_animation(gap_time: float)-> void:
	for i in range(5):
		main_logo.hide()
		japan_logo.hide()
		await get_tree().create_timer(gap_time).timeout
		main_logo.show()
		japan_logo.show()
		await get_tree().create_timer(gap_time).timeout
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if !GameManager.save_file_exists():
		#load_button.disabled = true  
	load_button.disabled = true  
	
	if GameManager.first_load:
	#intro scene
		await get_tree().create_timer(0.5).timeout
		star.show()
		star.play("default")
		await get_tree().create_timer(0.5).timeout
		star.hide()
		punch_animation(gap_time, size_multiplier)
		await get_tree().create_timer(2.5).timeout
		logo_animation(gap_time/6)
		await get_tree().create_timer(2.0).timeout
		var anima = Anima.begin(self, 'fade_out')
		anima.with({ node = main_logo, animation = 'fadeOut', duration = 0.3})
		anima.with({ node = japan_logo, animation = 'fadeOut', duration = 0.3})
		anima.with({ node = punch, animation = 'fadeOut', duration = 0.3})
		anima.play()
	
		#introduce buttons
		await get_tree().create_timer(gap_time*1.5).timeout
	start_button.show()
	load_button.show()
	exit_button.show()


func intro_text_show():
	GameManager.first_load = false
	start_button.hide()
	load_button.hide()
	exit_button.hide()
	await get_tree().create_timer(0.5).timeout
	text_panel.show()

	Anima.begin_single_shot(self) \
	.then(Anima.Node(start_button).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node(load_button).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node(exit_button).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($Intro_elements/Panel).anima_scale_y(1.0, 0.3).anima_from(0)) \
	.then(Anima.Node($Intro_elements/Panel/Label).anima_animation('typewrite', 0.03) ) \
	.then(Anima.Node(next_button).anima_animation('fade in', 2.0) ) \
	.set_visibility_strategy(ANIMA.VISIBILITY.TRANSPARENT_ONLY) \
	.play()
	next_button.show()


func _on_start_pressed() -> void:
	if GameManager.first_load:
		intro_text_show()
	else:
		get_tree().change_scene_to_file("res://Assets/Scenes/TransitionScreens/level_transition_screen.tscn")
		
func goto_main_story() -> void:
	text_panel.queue_free()
	get_tree().change_scene_to_file("res://Assets/Scenes/Cutscenes/Intro.tscn")

func _on_continue_pressed() -> void:
	turnOffMusic = true
	var anima = Anima.begin(self, 'fade_out')
	anima.with({ node = text_panel, animation = 'fadeOut', duration = 1.4})
	anima.with({ node = next_button, animation = 'fadeOut', duration = 1.4})
	anima.play()
	await get_tree().create_timer(2.5).timeout
	call_deferred("goto_main_story")

func _physics_process(delta: float) -> void:
	if turnOffMusic:
		turn_off_volume(delta, chunk)


func _on_exit_pressed() -> void:
	get_tree().quit()
