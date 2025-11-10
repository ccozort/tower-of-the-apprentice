extends Panel

@onready var item_display: Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	print('ui slot updated')
	if !slot.item:
		print("ui slot has no item")
		item_display.visible = false
	else: 
		item_display.visible = true
		item_display.texture = slot.item_display.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)
		


func _on_button_pressed() -> void:
	print('clicking inside inventory')
	print(get_parent())
