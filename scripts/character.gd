extends CharacterBody2D

@onready var as_character: AnimatedSprite2D = $as_character
@export var speed = 75
@export var friction = 0.5
@export var acceleration = 0.1
@export var sprint_multiplier = 2
@export var sprint_recovery = 25

var stationary: bool = false
var stamina_depleted: bool = false

func handle_animation() -> void:
	
	if Globals.current_state == "sleep":
		as_character.play("sleep")
		stationary = true
		return
	
	if !stationary:
		if Input.is_action_pressed("run") and Globals.stamina_progress > 0:
			if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
				as_character.play("run_horizontal")
				
				if Input.is_action_pressed("left"):
					as_character.flip_h = true
				else:
					as_character.flip_h = false
			elif Input.is_action_pressed("up") and Globals.stamina_progress > 0:
				as_character.play("run_up")
			elif Input.is_action_pressed("down") and Globals.stamina_progress > 0:
				as_character.play("run_down")
			else:
				as_character.play("idle_down")
		else:
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
	
	# Handle interactions
	if Input.is_action_just_pressed("interact"):
		if Globals.current_state == "idle":
			return
		elif Globals.current_state == "watering":
			as_character.play("watering_horizontal")
			stationary = true
		elif Globals.current_state == "planting":
			as_character.play("planting_horizontal")
			stationary = true
		elif Globals.current_state == "harvesting":
			as_character.play("harvest_horizontal")
			stationary = true

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
	
	if !stationary:
		var direction = get_input()
		var calculated_speed = speed
		if Input.is_action_pressed("run") and !stamina_depleted:
			calculated_speed = speed * sprint_multiplier
		
		if direction.length() > 0:
			velocity = velocity.lerp(direction.normalized() * calculated_speed, acceleration)
		else:
			velocity = velocity.lerp(Vector2.ZERO, friction)
		
		move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_animation()
	
	if !stationary and Input.is_action_pressed("run") and Globals.stamina_progress > 0 and !stamina_depleted:
		Globals.stamina_progress -= delta * 10
		if Globals.stamina_progress <= 0:
			stamina_depleted = true
	elif Globals.stamina_progress <= (100 + delta * 10):
		Globals.stamina_progress += delta * 10
		if Globals.stamina_progress >= sprint_recovery:
			stamina_depleted = false
		
	print(Globals.stamina_progress)
		
func _on_as_character_animation_finished() -> void:
	
	if Globals.current_state == "sleep":
		get_tree().change_scene_to_file("res://Scenes/round_over.tscn")
		
	as_character.play("idle_down")
	stationary = false
	Globals.current_state = "idle"
	
	
