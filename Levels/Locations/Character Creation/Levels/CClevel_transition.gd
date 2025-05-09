@tool
extends Area2D
class_name CCLevelTransition

enum SIDE {LEFT, RIGHT, TOP, BOTTOM}

@export_file("*.tscn") var level
@export var targetTransitionArea: String = "LevelTransition"

@export_category("Collision Area Settings")
@export_range(1, 12, 1, "or_greater") var size: int = 2:
	set(_v): 
		size = _v
		updateArea()
		
@export var exitSide: SIDE = SIDE.LEFT:
	set(_v):
		exitSide = _v
		updateArea()
@export var snapToGrid: bool = false:
	set(_v):
		_snapToGrid()

@onready var collision_shape: CollisionShape2D = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	PlayerManager.connect("race_changed", Callable(self, "_on_race_changed"))
	
	
	updateArea()
	if Engine.is_editor_hint():
		return
		
	monitoring = false
	placePlayer()
	
	await LevelManager.levelLoaded
	
	
	body_entered.connect(playerEntered)

func _on_race_changed():
	if PlayerManager.player.race.race_name != "None":
		monitoring = true
	else:
		monitoring = false


func updateArea()->void:
	var newRect: Vector2 = Vector2(32, 32)
	var newPosition: Vector2 = Vector2.ZERO
	
	if exitSide == SIDE.TOP:
		newRect.x *= size
		newPosition.y -= 16
	elif exitSide == SIDE.BOTTOM:
		newRect.x *= size
		newPosition.y += 16
	elif exitSide == SIDE.LEFT:
		newRect.y *= size
		newPosition.x -= 16
	elif exitSide == SIDE.RIGHT:
		newRect.y *= size
		newPosition.x += 16
		
	if collision_shape == null:
		collision_shape = get_node("CollisionShape2D")
		
	collision_shape.shape.size = newRect
	collision_shape.position = newPosition

func _snapToGrid()->void:
	position.x = round(position.x/16) * 16
	position.y = round(position.y/16) * 16
	
func playerEntered(_p: Node2D)->void:
	LevelManager.loadNewLevel(level, targetTransitionArea, getOffset())
	
func placePlayer()->void:
	if name != LevelManager.targetTransition:
		return
	PlayerManager.setPlayerPosition(global_position + LevelManager.positionOffset)

	
func getOffset()->Vector2:
	var offset : Vector2 = Vector2.ZERO
	var player_pos = PlayerManager.player.global_position
	
	if exitSide == SIDE.LEFT || exitSide == SIDE.RIGHT:
		offset.y = player_pos.y - global_position.y
		offset.x = 16
		if exitSide == SIDE.LEFT:
			offset.x *= -1
	else:
		offset.x = player_pos.x - global_position.x
		offset.y = 16
		if exitSide == SIDE.TOP:
			offset.y *= -1
			
	return offset
