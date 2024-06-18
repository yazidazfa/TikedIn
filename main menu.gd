extends Node

var last_button_pressed = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$btn_transition.connect("animation_finished", Callable(self, "_on_transition_animation_finished"))

func _on_mulai_btn_pressed():
	print("Loading another scene...")
	$btn_transition.play("btn_transition")

func _on_exit_btn_pressed():
	print("Exiting the program...")
	get_tree().quit()  # Exit the game

func _on_easy_btn_pressed():
	print("Easy button pressed")
	$btn_transition.play("change_scene")
	last_button_pressed = "easy"

func _on_hard_btn_pressed():
	print("Hard button pressed")
	$btn_transition.play("change_scene")
	last_button_pressed = "hard"

func _on_transition_animation_finished(animation_name: String):
	print("Animation finished:", animation_name)
	
	# Check if this node is still part of the scene tree
	if not is_instance_valid(self):
		print("Node instance is not valid, cannot continue.")
		return

	var scene_path = ""
	if animation_name == "change_scene":
		if last_button_pressed == "easy":
			scene_path = "res://Scene/Easy1.tscn"
		elif last_button_pressed == "hard":
			scene_path = "res://Scene/Hard1.tscn"
		else:
			print("Unknown last button pressed:", last_button_pressed)
			return

		if scene_path != "" and ResourceLoader.exists(scene_path):
			print("Loading scene:", scene_path)
			get_tree().change_scene_to_file(scene_path)
		else:
			print("Scene not found or not imported: ", scene_path)
