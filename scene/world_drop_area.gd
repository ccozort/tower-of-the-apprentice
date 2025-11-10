extends Control

const WORLD_ITEM = preload("res://world_item.tscn")


@onready var grid_container: GridContainer = $"../HUD/inventory_ui_control/MarginContainer/GridContainer"

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var node = WORLD_ITEM.instantiate()
	
	node.set_meta("item_data", data.item)
	node.get_node("Sprite2D").texture = data.item.image
	
	get_tree().current_scene.add_child(node)
	data.item = null
	node.global_position = get_global_mouse_position()

func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		mouse_filter = Control.MOUSE_FILTER_PASS
	if what == Node.NOTIFICATION_DRAG_END:
		mouse_filter = Control.MOUSE_FILTER_IGNORE



			
			
			
