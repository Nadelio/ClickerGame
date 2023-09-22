extends Label

@onready var prestige_text = $"../prestige_text"
@onready var not_enough = $"../not_enough"
@onready var not_enough_timer = $"../not_enough_timer"

#score
var score = 0

#modifiers that can be bought
var multi_modifier = 1
var addition_modifier = 0
var prestige_modifier = 0

func _ready():
	if(FileAccess.file_exists("user://player_save_data.txt") == false):
		_on_button_pressed()
	else:
		var file = FileAccess.open("user://player_save_data.txt", FileAccess.READ)
		score = file.get_line().to_int()
		multi_modifier = file.get_line().to_int()
		addition_modifier = file.get_line().to_int()
		prestige_modifier = file.get_line().to_int()
	prestige_text.text = "Prestige Score = " + str(prestige_modifier)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = str(score)

#main button
func _on_button_pressed():
	score += ((1+addition_modifier)*multi_modifier)+prestige_modifier
	var file = FileAccess.open("user://player_save_data.txt", FileAccess.WRITE)
	file.store_string(str(score) + "\n")
	file.seek_end()
	file.store_string(str(multi_modifier) + "\n")
	file.seek_end()
	file.store_string(str(addition_modifier) + "\n")
	file.seek_end()
	file.store_string(str(prestige_modifier) + "\n")


#first addition button
func _on_button_2_pressed():
	addition_modifier += 1
	score -= 10
	if(score < 0):
		addition_modifier -=1
		score += 10
		not_enough.text = str("Not Enough Score!")
		not_enough_timer.start(1)

#first multiply button
func _on_buy_3_pressed():
	multi_modifier *= 2
	score -= 1000
	if(score <0):
		multi_modifier /=2
		score += 1000
		not_enough.text = str("Not Enough Score!")
		not_enough_timer.start(1)


func _on_buy_2_pressed():
	addition_modifier += 10
	score -= 50
	if(score <0):
		addition_modifier -= 10
		score += 50
		not_enough.text = str("Not Enough Score!")
		not_enough_timer.start(1)


func _on_prestige_button_pressed():
	if(score != 0 and score > 10000):
		@warning_ignore("integer_division")
		prestige_modifier += ceil(score/1000)
		score = 0
		multi_modifier = 1
		addition_modifier = 0
		prestige_text.text = "Prestige Score = " + str(prestige_modifier)
	else:
		not_enough.text = str("Not Enough Score!")
		not_enough_timer.start(1)


func _on_reset_button_pressed():
	score = 0
	addition_modifier = 0
	multi_modifier = 1
	prestige_modifier = 0
	_on_button_pressed()
	prestige_text.text = "Prestige Score = " + str(prestige_modifier)
