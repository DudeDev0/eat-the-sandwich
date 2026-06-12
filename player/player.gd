extends CharacterBody2D


var speed: float = 100.0
var jump_velocity: float = -220.0
var gravity: float = 1200.0

var coyote_active: bool = false
var was_on_floor: bool = false

@onready var sprite: Sprite2D = $Sprite
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var coyote_timer: Timer = $CoyoteTimer


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

		if was_on_floor and not coyote_active:
			coyote_active = true
			coyote_timer.start()
	else:
		coyote_active = false
		coyote_timer.stop()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_active):
		velocity.y = jump_velocity
		coyote_active = false
		coyote_timer.stop()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		anim_player.play("walk")
		velocity.x = direction * speed
		sprite.flip_h = direction - 1.0
	else:
		anim_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, speed)

	was_on_floor = is_on_floor()

	move_and_slide()


func _on_coyote_timer_timeout() -> void:
	coyote_active = false

