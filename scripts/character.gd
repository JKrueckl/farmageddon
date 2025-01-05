extends CharacterBody2D

@onready var as_character: AnimatedSprite2D = $as_character

@export var speed = 200
@export var friction = 0.5
@export var acceleration = 0.1

func handle_animation() -> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		as_character.play("walk_horizontal")
		
		if Input.is_action_pressed("left"):
			as_character.flip_h = true
		else:
			as_character.flip_h = false
	elif Input.is_action_pressed("up"):
		as_character.play("walk_up")
	elif Input.is_action_pressed("down"):
		as_character.play("walk_down")
	else:
		as_character.play("idle_down")

func get_input() -> Vector2:
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var direction = get_input()

	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_animation()
