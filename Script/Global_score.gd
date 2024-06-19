extends Node

var total_score = 0
var score_easy1 = 0
var score_easy2 = 0
var score_easy3 = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_to_score1(amount):
	total_score += amount
	score_easy1 += amount

	
func add_to_score2(amount):
	total_score += amount
	score_easy2 += amount

	
func add_to_score3(amount):
	total_score += amount
	score_easy3 += amount
	
func reset_score():
	total_score = 0
	score_easy1 = 0
	score_easy2 = 0
	score_easy3 = 0
