extends State

func change_to_wall_slide():
	if player.is_on_wall_only():
		player.change_state("wall_slide", state_machine)

@export var player: CharacterBody2D
@export var ACCEL: float = 10.0
func physics_update(delta: float) -> void:
	player.player_sprites.play("idle")
	#gravity
	player.apply_gravity(delta)
	
	# If there's input, switch to Move state
	if player.input_direction != Vector2.ZERO:
		#print("idle->move")
		#state_machine.change_state("move")
		player.change_state("move", state_machine)
		#return

	# Smoothly slow to a stop horizontally
	player.velocity.x = lerp(player.velocity.x, 0.0, ACCEL * delta)
	
	if Input.is_action_just_pressed("up") and player.is_on_floor():
		player.change_state("jump", state_machine)
	#player.jump_using_coyote_timer(state_machine)
	
	# --- Wall Slide ---	
	change_to_wall_slide()
	
	# --- in Air ---
	if (not player.is_on_floor()) and (not player.is_on_wall()):
		player.change_state("in_air", state_machine)
	

	# --- Apply movement ---
	player.move_and_slide()
