extends Node2D

@onready var l_money: Label = $Sprite2D/L_money
@onready var l_seeds: Label = $Sprite2D/L_seeds
@onready var l_carrots: Label = $Sprite2D/L_carrots
@onready var l_bucket: Label = $Sprite2D/L_bucket



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	l_seeds.text = str(Globals.seeds)
	l_money.text = str(Globals.money)
	l_carrots.text = str(Globals.carrots)
	l_bucket.text = str(Globals.bucket_charges)
