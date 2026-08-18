extends State

@export var player: CharacterBody2D
@export var warp_sound: AudioStreamPlayer2D
func enter() -> void:
	warp_sound.play()
	player.player_sprites.play("warp_in")
	await player.player_sprites.animation_finished
	player.change_state("idle", player.state_access)
