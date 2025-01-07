extends Node2D

@onready var as_ground: AnimatedSprite2D = $AS_ground
@onready var as_plant: AnimatedSprite2D = $AS_plant
@onready var l_interact: Label = $L_interact
@onready var growth_timer: Timer = $growth_timer
@onready var l_harvest: Label = $L_harvest
@onready var l_water: Label = $L_water

var can_plant = false
var plant_currently_growing = false
var total_progress = 5
var current_progress = 0
var fully_grown = false
var is_in_range = false
var watered_plant = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	as_ground.play("ground", 0)
	as_ground.frame = 1
	l_interact.visible = false
	l_harvest.visible = false
	l_water.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	
	#Water
	if Input.is_action_just_pressed("interact") and (Globals.bucket_charges == 1) and (is_in_range) and (!watered_plant):
		as_ground.frame = 3
		
		# Set plant to watered
		watered_plant = true
		
		# Hide water label and show plant label
		l_water.visible = false
		l_interact.visible = true
		
		# Update global counts
		Globals.bucket_charges -= 1
	#Plant 
	elif Input.is_action_just_pressed("interact") and Globals.seeds > 0 and (is_in_range) and (!plant_currently_growing) and watered_plant:
		# change sprite to a carrot
		as_plant.play("carrot", 0)
		as_plant.frame = 0
		
		# plant is now growing
		plant_currently_growing = true
		
		# hide harvet label
		l_interact.visible = false
		
		# start growth timer
		growth_timer.start()	
		
		# update global counts
		Globals.seeds -= 1
	#Harvest
	elif Input.is_action_just_pressed("interact") and (fully_grown) and (is_in_range):
		# reset sprite to empty plot
		as_plant.play("empty_plot", 0)
		as_ground.frame = 1
		
		# reset plant
		plant_currently_growing = false
		fully_grown = false
		watered_plant = false
		
		# Hide pop-up labels
		l_harvest.visible = false
		l_water.visible = true
		
		# Update global counts
		Globals.money += 2
		Globals.carrots += 1

func _on_a_interact_body_entered(body: Node2D) -> void:
	is_in_range = true
	
	# Plant is currently growing
	if !plant_currently_growing and !watered_plant:
		l_water.visible = true
	elif !plant_currently_growing:
		l_interact.visible = true
	else:
		if fully_grown == true:
			l_harvest.visible = true


func _on_a_interact_body_exited(body: Node2D) -> void:
	l_interact.visible = false
	l_harvest.visible = false
	l_water.visible = false
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
