extends Node

var karakter_pelanggan = ["res://Character/Man-1.png.png", "res://Character/bapak bapak x1 (1).png", "res://Character/yor-forger-x1.png"]
var pesanan_dan_kode = {
	"kora-kora": "0001",
	"biang-lala": "0010"
}
var code_label : Label
var timer : Timer 

var kode_pesanan_saat_ini = ""
var input_player = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	panggil_pelanggan_baru()	
	code_label = $TextureRect/Input_Number

func panggil_pelanggan_baru():
	#var karakter_acak = karakter_pelanggan[randi() % karakter_pelanggan.size()]
	var pesanan_acak = pesanan_dan_kode.keys()[randi() % pesanan_dan_kode.size()]
	kode_pesanan_saat_ini = pesanan_dan_kode[pesanan_acak]
	print("kode pesanan saat ini: ", kode_pesanan_saat_ini)

	var customer = $TextureRect/CustomerContainer/CustomerInstance
	#customer.set_character(karakter_acak)
	$TextureRect/OrderLabel.text = pesanan_acak + " (" + kode_pesanan_saat_ini + ")" 

	input_player = ""  # Reset player input code
	$TextureRect/Timer.start(10)  # Set waktu tunggu pelanggan

func _on_btn_submit_pressed():
	proses_pesanan(input_player)

func proses_pesanan(barang_diberikan):
	if input_player == kode_pesanan_saat_ini:
		print("Pesanan benar! Kode input: ", barang_diberikan)
		# Tambahkan logika untuk menangani pesanan yang benar di sini
	else:
		print("Pesanan salah! Kode input: ", barang_diberikan)
		# Tambahkan logika untuk menangani pesanan yang salah di sini
	
	input_player = ""
	code_label.text = ""
	panggil_pelanggan_baru()  # Panggil pelanggan baru setelah pesanan diproses

func _on_btn_1_pressed():
	if input_player.length() < 4:
		input_player += "1"
	print("Player input code: ", input_player)
	update_input_code_label()

func _on_btn_0_pressed():
	if input_player.length() < 4:
		input_player += "0"
	print("Player input code: ", input_player)
	update_input_code_label()

func update_input_code_label():
	# Update the Label text to display player_input_code
	code_label.text = input_player

func _on_timer_timeout():
	print("Waktu tunggu pelanggan habis!")
	panggil_pelanggan_baru()
