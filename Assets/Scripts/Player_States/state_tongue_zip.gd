extends State

@export var sfx_tongue_launch: AudioStreamPlayer2D
@export var tongue_acceleration: float = 2500.0
@export var player: CharacterBody2D
@export var tongue_extension_speed: float = 2500.0
@export var tongue_speed: float = 1200.0
@export var arrival_distance: float = 30.0
var tongue_shooting: bool = false
var tongue_target: Vector2
var target

func shoot_tongue(delta: float) -> void:
	sfx_tongue_launch.play()
	var start: Vector2 = player.global_position

	var current_tip: Vector2 = player.tongue_line.to_global(
		player.tongue_line.points[1]
	)

	var direction: Vector2 = current_tip.direction_to(tongue_target)

	current_tip += direction * tongue_extension_speed * delta

	if current_tip.distance_to(tongue_target) <= tongue_extension_speed * delta:
		current_tip = tongue_target
		tongue_shooting = false

	player.tongue_line.points = PackedVector2Array([
		player.tongue_line.to_local(start),
		player.tongue_line.to_local(current_tip)
	])

func pull_player(delta: float) -> void:
	var direction: Vector2 = player.global_position.direction_to(tongue_target)

	player.velocity = player.velocity.move_toward(
		direction * tongue_speed,
		tongue_acceleration * delta
	)
	
	player.move_and_slide()
	
func pull_food() -> void:
	var direction :Vector2 = target.global_position.direction_to(player.global_position)

	target.global_position += direction * tongue_speed * get_physics_process_delta_time()

func update_tongue() -> void:

	if target.is_in_group("food"):
		tongue_target = target.global_position

	player.tongue_line.points = PackedVector2Array([
		player.tongue_line.to_local(player.global_position),
		player.tongue_line.to_local(tongue_target)
	])

func enter() -> void:
	target = null
	tongue_shooting = false

	player.tongue_line.visible = false
	player.tongue_line.clear_points()
	
	
	var mouse_position := player.get_global_mouse_position()
	var direction := player.global_position.direction_to(mouse_position)

	player.tongue_ray_cast.global_position = player.global_position
	player.tongue_ray_cast.target_position = direction * player.zip_range
	player.tongue_ray_cast.force_raycast_update()

	if not player.tongue_ray_cast.is_colliding():
		player.tongue_line.visible = false
		player.tongue_line.clear_points()

		player.change_state("in_air", player.state_access)
		return

	tongue_target = player.tongue_ray_cast.get_collision_point()
	target = player.tongue_ray_cast.get_collider()

	tongue_shooting = true

	player.tongue_line.visible = true
	player.tongue_line.points = PackedVector2Array([
		player.tongue_line.to_local(player.global_position),
		player.tongue_line.to_local(player.global_position)
	])
	
func finish_zip() -> void:
	var release_velocity: Vector2 = player.velocity * player.tongue_release_multiplier

	#player.tongue_line.visible = false
	player.velocity = release_velocity
	#player.tongue_line.clear_points()

	

	player.change_state("in_air", player.state_access)

func physics_update(delta: float) -> void:
	if Input.is_action_just_released("tongue_zip"):
		finish_zip()
		return
	
	if player.is_on_wall():
		player.change_state("wall_slide", player.state_access)
		return
		
	if target == null:
		finish_zip()
		player.change_state("in_air", player.state_access)
		return

	if tongue_shooting:
		shoot_tongue(delta)
		return

	if target.is_in_group("food"):
		pull_food()
	else:
		pull_player(delta)

	update_tongue()

	if target.is_in_group("food"):
		if target.global_position.distance_to(player.global_position) <= arrival_distance:
			finish_zip()
	else:
		if player.global_position.distance_to(tongue_target) <= arrival_distance:
			finish_zip()
