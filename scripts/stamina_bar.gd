extends Node2D

const Character = preload("res://scripts/character.gd")

@onready var stamina_bar: Sprite2D = $Control/stamina_bar

var stam_bar_max_scale = 1
var stam_bar_min_scale = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	stamina_bar.scale.x = Globals.stamina_progress / 100

	
