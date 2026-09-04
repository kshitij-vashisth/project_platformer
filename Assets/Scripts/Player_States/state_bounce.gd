extends State

@export var player_bounce_velocity: float = 400.0
@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func enter() -> void:
	player.toBounce = false
	player.jump_count = 1
	player.velocity.y = -player_bounce_velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	
	player.air_control(delta)
	
	if Input.is_action_just_pressed("up") and player.doubleJumpEnabled:
		#player.playerLastLeft = !player.isLeft
		player.change_state("double_jump",state_machine)
		
	if Input.is_action_just_pressed("shoot"):
		player.shoot_function(0)
	
	if player.is_on_floor_only():
		player.change_state("idle",player.state_access)
	
	if player.is_on_wall_only():
		player.change_state("wall_slide",player.state_access)
	
	player.move_and_slide()
