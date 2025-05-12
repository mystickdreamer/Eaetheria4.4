@tool
@icon("res://Assets/icons/question_bubble.svg")
extends DialogItem
class_name DialogChoice


var dialog_branches: Array[DialogBranch]


func _ready() -> void:
	super()
	for c in get_children():
		if c is DialogBranch:
			dialog_branches.append(c)
			
	
	
	
func _set_editor_display()->void:
	set_related_text()
	if dialog_branches.size() < 2:
		return
	example_dialog.set_dialog_choice(self)
	pass

func set_related_text()->void:
	#putting parent in a variable
	var _p = get_parent()
	#setting the parents node into a variable
	var _i = self.get_index()
	#setting to variable the parent of the diagchoice then subtracting 1 
	var _t = _p.get_child(_i - 1)
	if _t is DialogText:
		example_dialog.set_dialog_text(_t)
		example_dialog.content.visible_characters = -1


func _get_configuration_warnings() -> PackedStringArray:
	#check for dialog items
	if _check_for_dialog_items() == false:
		return ["Requires at least on DialogItem node."]
	else:
		return []
		

func _check_for_dialog_items()->bool:
	var _count: int = 0
	for c in get_children():
		if c is DialogBranch:
			_count += 1
			if _count > 1:
				return true
	return false
