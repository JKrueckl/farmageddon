extends Node2D

const Character = preload("res://scripts/character.gd")
@onready var _25_stamina: Sprite2D = $"Control/25_stamina"
@onready var _50_stamina: Sprite2D = $"Control/50_stamina"
@onready var _75_stamina: Sprite2D = $"Control/75_stamina"
@onready var _100_stamina: Sprite2D = $"Control/100_stamina"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.stamina_progress == 75:
		_100_stamina.visible = false
	elif Globals.stamina_progress == 50:
		_75_stamina.visible = false
	elif Globals.stamina_progress == 25:
		_50_stamina.visible = false
	else: 
		if Globals.stamina_progress == 0:
			_25_stamina.visible = false

	
