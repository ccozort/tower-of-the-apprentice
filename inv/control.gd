extends Control


const ITEM_SLOT = preload("res://inv/item_slot.tscn")
@onready var hand: Node2D = $"../../Hand"

var row_size = 10
var col_size = 3
var items = []

func _ready():
	for x in range(row_size):
		items.append([])
		for y in range(col_size):
			items[x].append([])
			
			var instance = ITEM_SLOT.instantiate()
			instance.global_position = Vector2(x*16, y*16)
			instance.slot_num = Vector2i(x,y)
			add_child(instance)
			items[x][y] = instance
			
func prep_item(new_item):
	var item = {}
	
	item["name"] = new_item.item_res.name
	item["inv_icon"] = new_item.item_res.inv_icon
	item["item_path"] = new_item.item_res.item_path
	item["stack_amnt"] = new_item.item_res.stack_amnt
	
	return item
	
func add_item(item):
	for y in range(col_size):
		for x in range(row_size):
			var slot = items[x][y]
			
			if slot.add_item(item):
				return true
	return false
	
func remove_item(slot_num):
	var slot = items[slot_num.x][slot_num.y]
	
	if slot.item != {}:
		if hand.item == {}:
			hand.add_item(slot.item, 1)
	slot.item_count -= 1
	slot.refresh_label()


func remove_stack(slot_num):
	var slot = items[slot_num.x][slot_num.y]
	
	if slot.item != {}:
		if hand.item == {}:
			hand.add_item(slot.item, slot.item_count)
			
		slot.item_count = 0
		slot.refresh_label()
		slot.item_icon.texture = null
		slot.item = {}
extends Node2D

const ITEM_SLOT = preload("res://inv/item_slot.tscn")
@onready var hand: Node2D = $"../../Hand"

var row_size = 10
var col_size = 3
var items = []

func _ready():
	for x in range(row_size):
		items.append([])
		for y in range(col_size):
			items[x].append([])
			
			var instance = ITEM_SLOT.instantiate()
			instance.global_position = Vector2(x*16, y*16)
			instance.slot_num = Vector2i(x,y)
			add_child(instance)
			items[x][y] = instance
			
func prep_item(new_item):
	var item = {}
	
	item["name"] = new_item.item_res.name
	item["inv_icon"] = new_item.item_res.inv_icon
	item["item_path"] = new_item.item_res.item_path
	item["stack_amnt"] = new_item.item_res.stack_amnt
	
	return item
	
func add_item(item):
	for y in range(col_size):
		for x in range(row_size):
			var slot = items[x][y]
			
			if slot.add_item(item):
				return true
	return false
	
func remove_item(slot_num):
	var slot = items[slot_num.x][slot_num.y]
	
	if slot.item != {}:
		if hand.item == {}:
			hand.add_item(slot.item, 1)
	slot.item_count -= 1
	slot.refresh_label()


func remove_stack(slot_num):
	var slot = items[slot_num.x][slot_num.y]
	
	if slot.item != {}:
		if hand.item == {}:
			hand.add_item(slot.item, slot.item_count)
			
		slot.item_count = 0
		slot.refresh_label()
		slot.item_icon.texture = null
		slot.item = {}
