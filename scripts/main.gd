extends Node2D
@onready var l_money: Label = $L_money
@onready var l_seeds: Label = $L_seeds
@onready var l_carrots: Label = $L_carrots
@onready var l_day_cycle: Label = $L_day_cycle
@onready var s_plot_4: Node2D = $plot_group/S_plot_4
@onready var s_plot_3: Node2D = $plot_group/S_plot_3
@onready var s_plot_2: Node2D = $plot_group/S_plot_2
@onready var s_plot: Node2D = $plot_group/S_plot

var current_hour = 5
var deadline_hour = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	s_plot_2.visible = false
	s_plot_3.visible = false
	s_plot_4.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	l_seeds.text = ": " + str(Globals.seeds)
	l_money.text = ": " + str(Globals.money)
	l_carrots.text = ": " + str(Globals.carrots)
	if (Globals.plots == 2) and (!s_plot_2.visible):
		s_plot_2.visible = true
	if (Globals.plots == 3) and (!s_plot_3.visible):
		s_plot_3.visible = true
	if (Globals.plots == 4) and (!s_plot_4.visible):
		s_plot_4.visible = true



func _on_t_day_cycle_timeout() -> void:
	current_hour += 1
	
	l_day_cycle.text = str(current_hour) + ":00"
	if current_hour == deadline_hour:
		get_tree().change_scene_to_file("res://Scenes/round_over.tscn")
		
		
