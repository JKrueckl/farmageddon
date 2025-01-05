extends Node2D

@onready var as_ground: AnimatedSprite2D = $AS_ground
@onready var as_plant: AnimatedSprite2D = $AS_plant
@onready var l_interact: Label = $L_interact
@onready var growth_timer: Timer = $growth_timer
@onready var l_harvest: Label = $L_harvest

var can_plant = false
var plant_currently_growing = false
var total_progress = 1
var current_progress = 0
var fully_grown = false
var is_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	as_ground.play("ground", 0)
	as_ground.frame = 1
	l_interact.visible = false
	l_harvest.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	#Plant 
	if Input.is_action_just_pressed("interact") and (can_plant == true) and Globals.seeds > 0 and (is_in_range) and (!plant_currently_growing):
		as_plant.play("carrot", 0)
		as_plant.frame = 0
		plant_currently_growing = true
		l_interact.visible = false
		growth_timer.start()
		Globals.seeds -= 1
		
	#Harvest
	if Input.is_action_just_pressed("interact") and (fully_grown == true) and (is_in_range):
		as_plant.play("empty_plot", 0)
		plant_currently_growing = false
		fully_grown = false
		can_plant = true
		l_harvest.visible = false
		Globals.money += 2
		Globals.carrots += 1
		l_interact.visible = true


func _on_a_interact_body_entered(body: Node2D) -> void:
	is_in_range = true
	if plant_currently_growing == false:
		l_interact.visible = true
		can_plant = true
	else:
		if fully_grown == true:
			l_harvest.visible = true


func _on_a_interact_body_exited(body: Node2D) -> void:
	l_interact.visible = false
	l_harvest.visible = false
	can_plant = false
	is_in_range = false


func _on_growth_timer_timeout() -> void:
	if plant_currently_growing == true:
		current_progress += 1
		if current_progress == total_progress:
			as_plant.frame += 1
			current_progress = 0
	if as_plant.frame + 1 == as_plant.sprite_frames.get_frame_count("carrot"):
		growth_timer.stop()
		fully_grown = true
		if is_in_range:
			l_harvest.visible = true
