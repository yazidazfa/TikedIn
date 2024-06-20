extends Node

var karakter_pelanggan = ["res://Character/Man-1.png.png", "res://Character/bapak bapak x1 (1).png", "res://Character/yor-forger-x1.png"]

@onready var audio_correct = $TextureRect/correct
@onready var audio_wrong = $TextureRect/wrong

var pesanan_dan_kode = {
	"Roller Coaster": {"kode": "0001", "harga": 50},
	"Rumah Hantu": {"kode": "0010", "harga": 20},
	"Komedi Putar": {"kode": "0100", "harga": 20},
	"Bumper Car": {"kode": "1000", "harga": 10},
	"Kora-Kora": {"kode": "1100", "harga": 50},
	"Ombak Banyu": {"kode": "1011", "harga": 20},
	"Wahana Ketangkasan": {"kode": "1010", "harga": 5},
	"Tong Setan": {"kode": "0110", "harga": 10},
	"Lempar Gelang": {"kode": "0011", "harga": 5}
}

var code_label: Label
var score_label: Label
var timer: Timer 
var score = 0  # Add this line to track the score
var game_timer: Timer  # Timer for the overall game duration
var time_left_label: Label  # Label to display the remaining time

var anim_player: AnimationPlayer
var kode_pesanan_saat_ini = ""
var pesanan_acak = ""  # Add this line to track the current order
var input_player = ""
var harga_pesanan = ""
var is_animating = false

var new_anim_player: AnimationPlayer
var sprite2d: Sprite2D
var order_label: Label  # Add this line to reference the OrderLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	anim_player = $TextureRect/CustomerContainer/CustomerInstance.get_node("AnimationPlayer")
	anim_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
	score_label = $TextureRect/ScoreLabel
	code_label = $TextureRect/Input_Number
	order_label = $TextureRect/OrderLabel  # Reference the OrderLabel node
	update_score_label()
	panggil_pelanggan_baru()

	game_timer = $TextureRect/GameTimer  # Assuming you have added a Timer node named GameTimer
	game_timer.set_wait_time(120)  # Set the game duration to 2 minutes (120 seconds)
	game_timer.connect("timeout", Callable(self, "_on_game_timer_timeout"))
	game_timer.start()

	time_left_label = $TextureRect/TimeLeftLabel  # Assuming you have a Label node to display the remaining time
	time_left_label.text = "Time Left: 2:00"  # Initialize the time display

	$TextureRect/CustomerTimer.connect("timeout", Callable(self, "_on_timer_timeout"))

	new_anim_player = $TextureRect/AnimationPlayer
	sprite2d = $TextureRect/KangTiket
	new_anim_player.play("kang tiket muncul")

func panggil_pelanggan_baru():
	var karakter_acak = karakter_pelanggan[randi() % karakter_pelanggan.size()]
	pesanan_acak = pesanan_dan_kode.keys()[randi() % pesanan_dan_kode.size()]  # Update this line
	kode_pesanan_saat_ini = pesanan_dan_kode[pesanan_acak]
	harga_pesanan = kode_pesanan_saat_ini["harga"]
	print("kode pesanan saat ini: ", kode_pesanan_saat_ini)

	var customer = $TextureRect/CustomerContainer/CustomerInstance
	customer.set_character(karakter_acak)
	is_animating = true
	order_label.visible = false  # Hide the OrderLabel
	$TextureRect/Uang.visible = false
	anim_player.play("Move to middle")

	$TextureRect/CustomerTimer.start(10)  # Set waktu tunggu pelanggan

func _on_animation_finished(anim_name):
	if anim_name == "Move to middle":
		is_animating = false
		order_label.visible = true  # Show the OrderLabel
		order_label.text = pesanan_acak + " (" + kode_pesanan_saat_ini["kode"] + ") - Harga: " + str(harga_pesanan)
		set_uang_texture(harga_pesanan)
	elif anim_name == "Move out":
		is_animating = false
		panggil_pelanggan_baru()

func _on_btn_submit_pressed():
	if not is_animating:
		proses_pesanan(input_player)

func proses_pesanan(barang_diberikan):
	if input_player == kode_pesanan_saat_ini["kode"]:
		print("Pesanan benar! Kode input: ", barang_diberikan)
		score += 100
		GlobalScore.add_to_score1(100)  # Add to global score
		update_score_label()  # Update the score display
		anim_player.play("Move out")
		$TextureRect/Uang.visible = false
		order_label.visible = false  # Hide the OrderLabel
		is_animating = true
		audio_correct.play()
		# Tambahkan logika untuk menangani pesanan yang benar di sini
	else:
		print("Pesanan salah! Kode input: ", barang_diberikan)
		anim_player.play("Move out")
		GlobalScore.add_to_score1(-50)
		score -= 50
		update_score_label()
		$TextureRect/Uang.visible = false
		order_label.visible = false  # Hide the OrderLabel
		is_animating = true
		audio_wrong.play()
		# Tambahkan logika untuk menangani pesanan yang salah di sini

	input_player = ""
	code_label.text = ""

func _on_btn_1_pressed():
	if not is_animating and input_player.length() < 4:
		input_player += "1"
	print("Player input code: ", input_player)
	update_input_code_label()

func _on_btn_0_pressed():
	if not is_animating and input_player.length() < 4:
		input_player += "0"
	print("Player input code: ", input_player)
	update_input_code_label()

func update_input_code_label():
	# Update the Label text to display player_input_code
	code_label.text = input_player

func _on_timer_timeout():
	print("Waktu tunggu pelanggan habis!")
	score -= 50
	GlobalScore.add_to_score1(-50)
	update_score_label()
	$TextureRect/Uang.visible = false
	order_label.visible = false  # Hide the OrderLabel
	is_animating = true
	anim_player.play("Move out")

func _on_backspace_pressed():
	if not is_animating and input_player.length() > 0:
		input_player = input_player.left(input_player.length() - 1)
		update_input_code_label()

func update_score_label():
	score_label.text = "Score: " + str(score)

func _on_game_timer_timeout():
	print("Game Over! Time's up!")
	# Implement the game over logic here, such as displaying a game over screen or transitioning to a different scene
	# For example, you might want to call a function to show the game over screen
	show_game_over_screen()

func show_game_over_screen():
	# Show the game over screen here
	# For example, you might want to change to a game over scene
	get_tree().change_scene_to_file("res://Scene/easy_lv1_complete.tscn")
	
func set_uang_texture(harga):
	if is_animating:
		$TextureRect/Uang.visible = false
	else:
		$TextureRect/Uang.visible = true
		match harga:
			100:
				$TextureRect/Uang.texture = load("res://uang/100.png")
			50:
				$TextureRect/Uang.texture = load("res://uang/50.png")
			20:
				$TextureRect/Uang.texture = load("res://uang/20.png")
			10:
				$TextureRect/Uang.texture = load("res://uang/10.png")
			5:
				$TextureRect/Uang.texture = load("res://uang/5.png")
			2:
				$TextureRect/Uang.texture = load("res://uang/2.png")
			1:
				$TextureRect/Uang.texture = load("res://uang/1.png")
		# Tambahkan case untuk nominal uang lainnya sesuai kebutuhan

func _process(delta):
	# Update the time left label every frame
	var time_left = int(game_timer.get_time_left())
	var minutes = time_left / 60
	var seconds = time_left % 60
	time_left_label.text = "Time Left: %d:%02d" % [minutes, seconds]
