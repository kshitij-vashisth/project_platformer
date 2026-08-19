extends AnimationPlayer
var fadeMusic: bool = false
@export var logo: Sprite2D
@export var black_box: ColorRect

#SpriteList======================================================>
@export var walk: AnimatedSprite2D
@export var double_jump: AnimatedSprite2D
@export var mosquito: AnimatedSprite2D
#================================================================>

#MusicList======================================================>
@export var part1: AudioStreamPlayer2D
@export var part2: AudioStreamPlayer2D
@export var magic: AudioStreamPlayer2D
@export var static_tv: VideoStreamPlayer
#===============================================================>

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var part1_tween = create_tween()
	part1.play()
	await get_tree().create_timer(12.0).timeout
	
	#part1_tween.tween_property(part1, "volume_db", -40.0, 2.0)
	#part1.stop()
	fadeMusic = true
	await get_tree().create_timer(2.9).timeout
	magic.play()
	await get_tree().create_timer(4.1).timeout
	#magic.stop()
	await get_tree().create_timer(0.9).timeout
	part2.play()
	await get_tree().create_timer(16.2).timeout
	static_tv.play()
	await get_tree().create_timer(6.8).timeout
	static_tv.hide()
	await get_tree().create_timer(0.3).timeout
	black_box.hide()
	logo.show()
	await get_tree().create_timer(2.8).timeout
	walk.show()
	await get_tree().create_timer(2.8).timeout
	double_jump.show()
	await get_tree().create_timer(2.8).timeout
	mosquito.show()
	await get_tree().create_timer(2.8).timeout
	walk.hide()
	await get_tree().create_timer(1.4).timeout
	double_jump.hide()
	mosquito.hide()
	await get_tree().create_timer(0.7).timeout
	logo.hide()
	await get_tree().create_timer(0.7).timeout
	get_tree().change_scene_to_file("res://Assets/Scenes/TransitionScreens/level_transition_screen.tscn")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fadeMusic:
		if part1.volume_db > -60.0:
			part1.volume_db -= 10.0 * delta
		
