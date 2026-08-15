extends State

@export var player: CharacterBody2D

func enter() -> void:
	player.jump_sound.play() 
	player.velocity.y = player.jump_velocity
	player.jump_count += 1
	print("jumping from wall")
	#player.player_sprites.flip_h = player.check_wall()
	#player.velocity = Vector2(player.calculate_knockback_velocity(player.check_wall()), player.jump_velocity/2)
	if player.look_dir < 0:
		print("wall jump to right")
		player.velocity.x = player.knockback_velocity
	
	if player.look_dir > 0:
		print("wall jump to left")
		player.velocity.x = -player.knockback_velocity
	#player.isLeft = !player.isLeft
	#player.player_sprites.flip_h = player.isLeft
		
	
func physics_update(delta: float) -> void:
	player.player_sprites.play("jump")
	
	player.flip_sprite()
	player.apply_gravity(delta)
	player.air_control(delta)
	
	
	
	
	if player.is_on_floor():
		player.change_state("idle",state_machine)
		
	if player.is_on_wall_only():
		player.change_state("wall_slide",state_machine)
	
	if Input.is_action_just_pressed("up") and player.doubleJumpEnabled:
		player.change_state("double_jump",state_machine)
	
	if Input.is_action_just_pressed("up") and not player.doubleJumpEnabled:
		pass


	player.move_and_slide()
