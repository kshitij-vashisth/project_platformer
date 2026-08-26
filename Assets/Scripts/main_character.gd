extends CharacterBody2D
var jump_count: int = 0
var isLeft: bool
#var isDead: bool = false
@export var doubleJumpEnabled: bool = false
var canMove: bool = true
var playerLastLeft: bool
var look_dir: int = 0
@export var player_sprites :AnimatedSprite2D
@export var slide_speed: int = 4000
var input_direction = Vector2.ZERO
var last_direction: float
@export var game_manager: Node
@export var move_speed: float = 200.0
@export var move_accel: float = 15.0
@export var jump_sound: AudioStreamPlayer2D
@export var player_hurt_sound: AudioStreamPlayer2D
@export var hurt_velocity_y: float = 200.0
@export var zip_range: float = 1000.0
@export var tongue_release_multiplier: float = 1.0
@export var sfx_defeat: AudioStreamPlayer2D

@onready var tongue_ray_cast: RayCast2D = %TongueRayCast
@onready var tongue_line: Line2D = %TongueLine
@onready var aim_line: Line2D = %AimLine


# finer parameters for smoother movement=====================================#
var wall_pushoff_available: bool = true
@export var hang_time: float = 0.15
@export var coyote_time: float
@export var wall_pushback_hang_time: float = 0.15
@export var wall_push_off_hang_time: float = 0.25
#============================================================================#

# air maneuverability parameters=============================================#
@export var air_accel: float = 10.0
@export var push_off: float = 20.0
#============================================================================#


func clear_tongue() -> void:
	tongue_line.visible = false
	tongue_line.clear_points()

func player_dying() -> void:
	player_sprites.play("destroyed")
	hide()

func hurt()-> void:
	#velocity.y += -hurt_velocity_y
	#velocity.x += -look_dir*2500 
	player_sprites.play("hurt")
	#player_hurt_sound.play()

func check_look_dir() -> void:
	var dir_check: int
	dir_check = 0
	if look_dir != dir_check:
		print(look_dir)
		dir_check = look_dir
func flip_sprite() -> void:
	isLeft = direction_calculate(velocity.x)
	player_sprites.flip_h = isLeft

# finer movement functions===================================================#
func coyote_checker(_was_on_floor: bool) -> void:
	#if was_on_floor and !is_on_floor():
		#coyote_timer.start()
	pass
		
func jump_using_coyote_timer(_state_machine) -> void:
	#if Input.is_action_just_pressed("up") and (is_on_floor() or coyote_timer.is_stopped()):
		#change_state("jump", state_machine)
	pass
#============================================================================#

#wall_checker_ray casts------------------------------------------------------#
@onready var wall_check_left: RayCast2D = %wall_direction_checker_left       #
@onready var wall_check_right: RayCast2D = %wall_direction_checker_right     #
#----------------------------------------------------------------------------#
@export var knockback_velocity: float = 800.0
#gravity_parameters_for jump---------------------------------------------------------------------------------------#
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
@export  var state_access : StateMachine
#-------------------------------------------------------------------------------------------------------------------#


#Functions======================================================================================================#
func wall_end_fall()->void:
	if isLeft and not wall_check_left.is_colliding():
		change_state("in_air", state_access)
	
	if !isLeft and not wall_check_right.is_colliding():
		change_state("in_air", state_access)

#function to change state
func change_state(desired_state_name: String, state_machine):
	print("changing state")
	clear_tongue()
	var current_state_name = str(state_access.current_state)
	print(current_state_name.substr(0,current_state_name.find(":")).to_lower()+"->"+desired_state_name)
	state_machine.change_state(desired_state_name)

func jump()-> void:
	change_state("jump", state_access)

# orients face for wall jumps and wall slides===#
func face_orientation() -> void:
	if velocity.x != 0:	
		look_dir = sign(velocity.x)
#================================================#

# air control function==========================================#
func air_control(delta: float) -> void:
	var input_x = input_direction.x
	var target_x = input_x * move_speed  # use your player's SPEED
	velocity.x = lerp(velocity.x, target_x, air_accel * delta)
	if velocity.x < 0:
		playerLastLeft = true
	elif velocity.x > 0:
		playerLastLeft = false
#===============================================================#

# Functions for handling gravity==============================#
func gravity_get() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity
	
func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity_get() * delta

func direction_calculate(x_velocity: float) -> bool:
	var PlayerisLeft: bool = x_velocity < 0
	return PlayerisLeft

func gravity_for_jump(delta) -> void:
	velocity.y += gravity_get() * delta
# End of functions for handling gravity=======================#


# End of functions==============================================================================================#
#func _ready() -> void:
	#coyote_timer.wait_time = coyote_time 

func _physics_process(_delta: float) -> void:
	var lastLives: int = GameManager.lives
	#orients face for wall jumps and wall slides===#
	face_orientation()
	#==============================================#
	
	#if GameManager.lives < lastLives:
		#isDead = true
		#dead()
	
	
	if is_on_floor():
		jump_count = 0
	input_direction.x = Input.get_axis("left", "right")
	#input_direction.y = Input.get_axis("up", "down")
	var was_on_floor: bool = is_on_floor()
	coyote_checker(was_on_floor)

func _process(delta):
	var mouse_position := get_global_mouse_position()
	var direction := global_position.direction_to(mouse_position)

	aim_line.points = PackedVector2Array([
		aim_line.to_local(global_position),
		aim_line.to_local(global_position + direction * 1000.0)
	])
