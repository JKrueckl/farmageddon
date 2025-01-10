extends Node2D

@onready var rigid_body_2d: RigidBody2D = $RigidBody2D
@onready var l_quantity: Label = $RigidBody2D/L_quantity
@onready var carrot: Sprite2D = $RigidBody2D/L_quantity/carrot
@onready var coin: Sprite2D = $RigidBody2D/L_quantity/coin
@onready var water_bucket: Sprite2D = $RigidBody2D/L_quantity/water_bucket
@onready var carrot_seed: Sprite2D = $RigidBody2D/L_quantity/carrot_seed

var quantity = 0
var item = "none"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var positive = ""
	if quantity >= 0:
		positive = "+"
	
	if len(positive + str(quantity)) > 2:
		carrot.position.x += 10
		carrot_seed.position.x += 10
		coin.position.x += 10
		water_bucket.position.x += 10
	
	l_quantity.text = positive + str(quantity)
	if item == "carrot":
		carrot.visible = true
	elif item == "carrot_seed":
		carrot_seed.visible = true
	elif item == "coin":
		coin.visible = true
	elif item == "water_bucket":
		water_bucket.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_kill_timer_timeout() -> void:
	queue_free()


func _on_fade_timer_timeout() -> void:
	modulate.a -= .1
	
