extends Panel

const GREEN_WAND = preload("uid://fni2q7naqokf")
const RED_WAND = preload("uid://cgavbjxgq4326")
const YELLOW_WAND = preload("uid://vv31k0ur1y3m")

func _ready() -> void:
	
	Input.set_custom_mouse_cursor(YELLOW_WAND, Input.CURSOR_ARROW, Vector2(16,16))
	Input.set_custom_mouse_cursor(GREEN_WAND, Input.CURSOR_CAN_DROP, Vector2(16,16))
	Input.set_custom_mouse_cursor(RED_WAND, Input.CURSOR_FORBIDDEN, Vector2(16,16))
	Input.set_custom_mouse_cursor(YELLOW_WAND, Input.CURSOR_DRAG, Vector2(16,16))


var data_bk
func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if data_bk:
				data_bk.icon.show()
				data_bk = null
