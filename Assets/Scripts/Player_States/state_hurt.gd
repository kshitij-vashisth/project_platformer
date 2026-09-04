extends State

@export var player: CharacterBody2D
@export var hurt_sound: AudioStreamPlayer

var hurt_timer: float = 0.0
const HURT_LOCK_TIME: float = 0.08


func enter() -> void:
	player.canMove = false
	hurt_timer = 0.0
	player.velocity.y += -player.hurt_velocity_y
	#player.velocity.x += -player.look_dir*2500 
	player.player_sprites.play("hurt")
	hurt_sound.play()
	#await get_tree().create_timer(0.1).timeout

func physics_update(delta: float) -> void:
	#await get_tree().create_timer(0.08).timeout
	hurt_timer += delta
	if hurt_timer < HURT_LOCK_TIME:
		return
		
	if not player.is_on_floor_only() and not player.is_on_wall_only():
		player.jump_count = 1
		player.change_state("in_air",state_machine)
	
	if player.is_on_floor_only():
		player.change_state("idle",state_machine)
	
	if player.is_on_wall_only():
		player.change_state("wall_slide",state_machine)
