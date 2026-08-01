extends State
@export var player: CharacterBody2D
#var wall_pushoff_available: bool = true
#var wall_pushoff_time = player.wall_pushback_hang_time

# wall_pushoff timer function =======================#
func wall_pushoff_timeout() -> void:
	player.wall_pushoff_available = true
func wall_pushoff_timer() -> void:
	get_tree().create_timer(player.wall_pushback_hang_time).timeout.connect(wall_pushoff_timeout)
	
func wall_gravity_act_after_push() -> void:
	get_tree().create_timer(player.wall_push_off_hang_time).timeout.connect(wall_pushoff_timeout)
	#pass
#====================================================#



func enter() -> void:
	player.wall_pushoff_available = false
	print("sliding")

func physics_update(delta: float) -> void:
	player.jump_count = 0
	if player.look_dir < 0:
		player.isLeft = true
		player.player_sprites.flip_h = player.isLeft
	
	if player.look_dir > 0:
		player.isLeft = false
		player.player_sprites.flip_h = player.isLeft
	#player.player_sprites.flip_h = !player.isLeft
	#player.direction_collision()
	player.velocity.y = 0
	if player.velocity.y < player.slide_speed:
		player.player_sprites.play("wall_slide")
		player.velocity.y += player.fall_gravity * delta * 0.8
	
	## --- Horizontal air control ---
	#player.air_control(delta)
	
	
	if Input.is_action_just_pressed("up"):
		state_machine.change_state("wall_jump")
	
	#if not player.is_on_wall():
		#print("wall slide->idle")
		#state_machine.change_state("idle")
	
	if player.is_on_floor():
		print("wall slide->idle")
		state_machine.change_state("idle")
	
	if Input.is_action_just_pressed("right"):
		if not player.wall_pushoff_available:
			wall_pushoff_timer()
			player.isLeft = false
			player.player_sprites.flip_h = player.isLeft
			player.velocity.x = player.push_off
			player.air_control(delta)
			wall_gravity_act_after_push()
			player.player_sprites.play("double_jump")
			player.wall_pushoff_available = false
			player.change_state("in_air", state_machine)
	
	if Input.is_action_just_pressed("left"):
		if not player.wall_pushoff_available:
			wall_pushoff_timer()
			player.isLeft = true
			player.player_sprites.flip_h = player.isLeft
			player.velocity.x = -player.push_off
			player.air_control(delta)
			wall_gravity_act_after_push()
			player.player_sprites.play("double_jump")
			player.wall_pushoff_available = false
			player.change_state("in_air", state_machine)
	
	player.move_and_slide()
