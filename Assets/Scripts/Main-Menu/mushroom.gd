extends CharacterBody2D
@export var logo: AnimatedSprite2D
var dead: bool = false
var dying: bool = false
var SPEED = 300.0
var direction = -1
var health = 1

var turn_timer = 0.0
var TURN_INTERVAL = 1.9  # seconds between turns

var life_timer = 0.0
var LIFETIME = 6.7  # seconds before death (e.g. 3 turns worth)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func add_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func move_enemy() -> void:
	if dying:
		return
	velocity.x = SPEED * direction
	animated_sprite_2d.play("run")

func turn_around(delta: float) -> void:
	if dying:
		return
	turn_timer += delta
	if turn_timer >= TURN_INTERVAL:
		turn_timer = 0.0
		direction = -direction
		animated_sprite_2d.scale.x *= -1

func death(delta: float) -> void:
	if dying:
		return
	life_timer += delta
	if life_timer >= LIFETIME:
		dying = true
		SPEED = 0
		velocity.x = 0
		animated_sprite_2d.play("death")
		#await animated_sprite_2d.animation_finished
		dead = true

func _physics_process(delta: float) -> void:
	logo.hide
	if dead:
		logo.show()
		return
	add_gravity(delta)
	move_enemy()
	turn_around(delta)
	death(delta)
	move_and_slide()
	
