@tool
@icon("res://Assets/icons/answer_bubble.svg")
extends DialogItem
class_name DialogBranch

@export var text: String = "ok..." :set = _set_text

signal selected

var dialog_items: Array[DialogItem]



func _ready() -> void:
	super()
	if Engine.is_editor_hint():
		return
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)

func _set_editor_display()->void:
	var _p = get_parent()
	if _p is DialogChoice:
		set_related_text()
		if _p.dialog_branches.size() <2:
			return
		example_dialog.set_dialog_choice(_p as DialogChoice)
		pass
	pass
	
func set_related_text()->void:
	#putting parent in a variable
	var _p = get_parent()
	var _p2 = _p.get_parent()
	#2 levels up index set to variable
	var _t = _p2.get_child(_p.get_index()-1)
	if _t is DialogText:
		example_dialog.set_dialog_text(_t)
		example_dialog.content.visible_characters = -1
	pass

func _set_text(value: String)->void:
	text = value
	if Engine.is_editor_hint():
		if example_dialog != null:
			_set_editor_display()
