extends Node2D

@onready var l_interact: Label = $A_interact/L_interact
const POPUP_ICONS = preload("res://scenes/popup_icons.tscn")

var is_in_range = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	l_interact.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and (is_in_range == true) and (Globals.bucket_charges < 4):
		var popup = POPUP_ICONS.instantiate()
		popup.quantity = +1
		popup.item = "water_bucket"
		popup.position = Vector2(10, -10)
		add_child(popup)
		
		Globals.bucket_charges += 1

func _on_a_interact_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_in_range = true
		l_interact.visible = true

func _on_a_interact_body_exited(body: Node2D) -> void:
	is_in_range = false
	l_interact.visible = false
	
