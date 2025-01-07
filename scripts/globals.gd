extends Node

var seeds = 1
var money = 0
var carrots = 0
var round = 1
var carrot_multiplyer = 2
var goal = 10
var plots = 1
var max_plots = 4
var bucket_charges = 0
var current_state = "idle"

func reset_game() -> void:
	seeds = 1
	money = 0
	carrots = 0
	round = 1
	goal = 20
	plots = 1
	bucket_charges = 0
	current_state = "idle"
