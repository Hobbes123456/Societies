extends Node2D

@export var door_width: int = 8
@export var door_open_frame_length: float = 0.1

var door_opening: bool = false
var door_closing: bool = false

@onready var door: Sprite2D = $Door/CanvasGroup/Door
@onready var default_door_position: Vector2 = door.global_position


func _on_door_interactable_entered() -> void:
	open_door()


func _on_door_interactable_exited() -> void:
	close_door()


func open_door() -> void:
	door_opening = true
	door_closing = false
	for frame in abs((default_door_position.x - door_width) - door.global_position.x):
		if door_closing or not door_opening:
			break
		door.global_position.x -= 1
		await get_tree().create_timer(door_open_frame_length).timeout
	door_opening = false


func close_door() -> void:
	door_closing = true
	door_opening = false
	for frame in abs(default_door_position.x - door.global_position.x):
		if door_opening or not door_closing:
			break
		door.global_position.x += 1
		await get_tree().create_timer(door_open_frame_length).timeout
	door_closing = false

