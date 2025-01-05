extends Node2D
@onready var l_collect: Label = $L_collect
@onready var l_goal: Label = $L_goal
@onready var l_good: Label = $L_good
@onready var b_good: Button = $B_good
@onready var b_bad: Button = $B_bad
@onready var l_bad: Label = $L_bad
@onready var l_next_goal: Label = $L_next_goal




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	l_collect.text = "You collected " + str(Globals.carrots) + " carrots."
	l_goal.text = "Bunny was expecting " + str(Globals.goal) + " carrots."
	l_next_goal.text = "Next goal is " + str(Globals.goal * Globals.carrot_multiplyer) + " carrots."
	if Globals.carrots >= Globals.goal:
		l_good.visible = true
		l_bad.visible = false
		b_good.visible = true
		l_next_goal.visible = true
	else:
		l_good.visible = false
		l_bad.visible = true
		b_good.visible = false
		l_next_goal.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_b_good_pressed() -> void:
	Globals.goal *= Globals.carrot_multiplyer
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_b_bad_pressed() -> void:
	Globals.reset_game()
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
