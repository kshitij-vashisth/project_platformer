extends State

@export var player: CharacterBody2D

@export var web_speed := 1200.0
@export var arrival_distance := 30.0

var tongue_target: Vector2

func enter() -> void:
	var mouse_position := player.get_global_mouse_position()
	var direction := player.global_position.direction_to(mouse_position)
	
	player.tongue_ray_cast.global_position = player.global_position
	player.tongue_ray_cast.target_position = direction * 1000.0
	player.tongue_ray_cast.force_raycast_update()
	
	print("Player: ", player.global_position)
	print("Mouse: ", mouse_position)
	print("Direction: ", direction)
	
	player.tongue_ray_cast.target_position = direction * 1000.0
	player.tongue_ray_cast.force_raycast_update()

	if not player.tongue_ray_cast.is_colliding():
		player.change_state("in_air", player.state_access)
		return

	tongue_target = player.tongue_ray_cast.get_collision_point()
	
	print("Tongue target: ", tongue_target)

	player.tongue_line.visible = true
	player.tongue_line.points = PackedVector2Array([
		player.to_local(player.global_position),
		player.to_local(tongue_target)
	])
	
func finish_zip() -> void:
	player.tongue_line.visible = false

	player.velocity = Vector2.ZERO

	player.change_state("in_air", player.state_access)

func physics_update(delta: float) -> void:
	var direction := player.global_position.direction_to(tongue_target)

	player.velocity = direction * web_speed
	player.move_and_slide()

	if player.global_position.distance_to(tongue_target) <= arrival_distance:
		finish_zip()
	#pass
