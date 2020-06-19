extends Control

var dialog = ['Quem sou eu?... e.. Onde estou?', 'Se eu seguir essas pegadas devo chegar em algum lugar.']

var dialog_index = 0
var finished = false

func _ready():
	load_dialog()

func _process(delta):
	$"TextureRect/next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept") and finished == true:
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$TextureRect/RichTextLabel.bbcode_text = dialog[dialog_index]
		$TextureRect/RichTextLabel.percent_visible = 0
		$TextureRect/Tween.interpolate_property($TextureRect/RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$TextureRect/Tween.start()	
	else:
		queue_free()
	dialog_index += 1
	
func _on_Tween_tween_completed(object, key):
	finished = true
