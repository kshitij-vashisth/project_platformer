extends Panel

#MusicList======================================================>
@export var part1: AudioStreamPlayer2D
#===============================================================>


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#part1.play()
	Anima.begin_single_shot(self) \
	#.then(Anima.Node(self).anima_scale_y(1.0, 0.3).anima_from(0)) \
	.then(Anima.Node($VBoxContainer/sprite1).anima_animation('fade in', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite1/Label1).anima_animation('typewrite', 0.03) ) \
	.wait(2.0) \
	.then(Anima.Node($VBoxContainer/sprite1).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite1/Label1).anima_animation('fade out', 0.1) ) \
	.then(Anima.Node($VBoxContainer/sprite2).anima_animation('fade in', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite2/Label2).anima_animation('typewrite', 0.03) ) \
	.wait(2.0) \
	.then(Anima.Node($VBoxContainer/sprite2).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite2/Label2).anima_animation('fade out', 0.1) ) \
	.then(Anima.Node($VBoxContainer/sprite3).anima_animation('fade in', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite3/Label3).anima_animation('typewrite', 0.03) ) \
	.wait(2.0) \
	.then(Anima.Node($VBoxContainer/sprite3).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite3/Label3).anima_animation('fade out', 0.1) ) \
	.then(Anima.Node($VBoxContainer/sprite4).anima_animation('fade in', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite4/Label4).anima_animation('typewrite', 0.03) ) \
	.then(Anima.Node($VBoxContainer/sprite4/Label5).anima_animation('typewrite', 0.03) ) \
	.wait(2.0) \
	.then(Anima.Node($VBoxContainer/sprite4).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite4/Label4).anima_animation('fade out', 0.1) ) \
	.then(Anima.Node($VBoxContainer/sprite4/Label5).anima_animation('fade out', 0.1) ) \
	.then(Anima.Node($VBoxContainer/sprite5).anima_animation('fade in', 0.3) ) \
	.wait(4.0) \
	.then(Anima.Node($VBoxContainer/sprite5).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite6).anima_animation('fade in', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite6/Label6).anima_animation('typewrite', 0.03) ) \
	.wait(2.0) \
	.then(Anima.Node($VBoxContainer/sprite6).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite6/Label6).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite7).anima_animation('fade in', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite7/Label7).anima_animation('typewrite', 0.03) ) \
	.wait(2.0) \
	.then(Anima.Node($VBoxContainer/sprite7).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite7/Label7).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite8).anima_animation('fade in', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite8/Label8).anima_animation('typewrite', 0.03) ) \
	.wait(1.0) \
	.then(Anima.Node($LastPanel).anima_scale_y(1.0, 0.3).anima_from(0)) \
	.then(Anima.Node($LastPanel/Label9).anima_animation('typewrite', 0.03) ) \
	.wait(2.0) \
	.then(Anima.Node($VBoxContainer/sprite8).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($VBoxContainer/sprite8/Label8).anima_animation('fade out', 0.3) ) \
	.then(Anima.Node($LastPanel).anima_animation('fade out', 0.3) ) \
	.set_visibility_strategy(ANIMA.VISIBILITY.TRANSPARENT_ONLY) \
	.play_with_delay(0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
