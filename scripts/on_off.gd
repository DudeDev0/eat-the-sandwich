extends Area2D

enum Mode {
	DISAPPEAR,
	APPEAR
}

@export var type: Mode

@export var layer: TileMapLayer


func _on_body_exited(_body: Node2D) -> void:
	if type == Mode.DISAPPEAR:
		layer.enabled = true
	else:
		layer.enabled = false

func _on_body_entered(_body: Node2D) -> void:
	if type == Mode.DISAPPEAR:
		layer.enabled = false
	else:
		layer.enabled = true

