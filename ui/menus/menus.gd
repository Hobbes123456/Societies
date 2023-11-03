extends Control

@onready var title_screen: Control = $TitleScreen
@onready var save_select: Control = $SaveSelect
@onready var play_button: Button = $TitleScreen/VBoxContainer/PlayButton


func _ready() -> void:
	play_button.grab_focus()


func _on_play_button_pressed() -> void:
	SceneManager.change_scene("res://world/world.tscn")


func _on_saves_button_pressed() -> void:
	await fade(
		[
			$TitleScreen/VBoxContainer/TitleLabel, 
			$TitleScreen/VBoxContainer/PlayButton, 
			$TitleScreen/VBoxContainer/SavesButton, 
			$TitleScreen/VBoxContainer/SettingsButton
		], 
		1.0, 
		0.0
	)
	title_screen.hide()
	save_select.show()
	save_select.start()
	await fade(
		[
			$SaveSelect/VBoxContainer/TitleLabel, 
			$SaveSelect/VBoxContainer/Slot1Button, 
			$SaveSelect/VBoxContainer/Slot2Button, 
			$SaveSelect/VBoxContainer/BackButton, 
			$SaveSelect/SlotEditor
		],
		0.0, 
		1.0
	)


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_title_screen_visibility_changed() -> void:
	if title_screen and title_screen.visible:
		play_button.grab_focus()
		await fade(
			[
				$TitleScreen/VBoxContainer/TitleLabel, 
				$TitleScreen/VBoxContainer/PlayButton, 
				$TitleScreen/VBoxContainer/SavesButton, 
				$TitleScreen/VBoxContainer/SettingsButton
			], 
			0.0, 
			1.0
		)


func fade(nodes: Array, from: float, to: float) -> void:
	for node in nodes:
		node.modulate.a = from
	
	for node in nodes:
		var t = get_tree().create_tween()
		t.tween_property(node, "modulate", Color(1, 1, 1, to), 0.6)
		await get_tree().create_timer(0.2).timeout
	await get_tree().create_timer(0.4).timeout
