extends State
@export var player: CharacterBody2D

const MAX_JUMPS: int = 2

func double_jump() -> void:
	if player.jump_count < MAX_JUMPS:
		print("double jump initiated")
		player.player_sprites.play("double_jump")
		player.velocity.y = player.jump_velocity
		
		player.jump_count = 2
		print("post double jump count: "+str(player.jump_count))
	
	else:
		player.player_sprites.play("double_jump")
		player.velocity.y = player.jump_velocity/2

func enter() -> void:
	print("double_jump")
	print("player jump count: "+str(player.jump_count))
	player.jump_sound.play()
	double_jump()

func physics_update(delta: float) -> void:
	# --- Horizontal air control ---
	player.flip_sprite()
	player.air_control(delta)

	# --- Gravity ---
	#player.gravity_for_jump(delta)
	player.apply_gravity(delta)

	# --- Landed? ---
	if player.is_on_floor():
		print("player jump count: "+str(player.jump_count))
		print("double_jump->idle")
		player.jump_count = 0
		state_machine.change_state("idle")
		
	# --- Wall Slide ---
	if player.is_on_wall_only():
		print("double_jump->wall_slide")
		state_machine.change_state("wall_slide")
	
	if Input.is_action_just_pressed("tongue_zip"):
		player.change_state("tongue_zip", state_machine)
	
	# --- Apply movement ---
	player.move_and_slide()
