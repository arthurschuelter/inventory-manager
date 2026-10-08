extends Node
class_name InventoryManager

var inventory : Array[Item] = []
@export var max_capacity: int = 0

signal item_inserted(item: Item)

func Insert(item: Item) -> void:
	if not canInsert():
		return
	
	inventory.append(item)
	item_inserted.emit(item)

func canInsert() -> bool:
	if inventory.size() < max_capacity:
		return true
	return false

func SortInventory() -> void:
	inventory.sort_custom(func arrange_items(a: Item, b: Item): return a.description < b.description)

func ArrangeInventory(old_idx: int, new_idx: int) -> void:
	var item: Item = inventory.pop_at(old_idx)
	inventory.insert(new_idx, item)
	
func PrintInventory() -> void:
	print("Inventory")
	for item in inventory:
		print(" > ", item.description)
