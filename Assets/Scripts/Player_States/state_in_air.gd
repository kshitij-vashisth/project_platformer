extends State

@export var player: CharacterBody2D

func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	#player.player_sprites.play("jump")
	player.isLeft = player.direction_calculate(player.velocity.x)
	player.player_sprites.flip_h = player.isLeft
	player.air_control(delta)
	
	if Input.is_action_just_pressed("up"):
		player.change_state("double_jump",state_machine)
	
	# switch to wall slide
	if player.is_on_wall_only():
		player.change_state("wall_slide", state_machine)
	
	# switch to idle
	if player.is_on_floor():
		player.change_state("idle", state_machine)

	player.move_and_slide()
