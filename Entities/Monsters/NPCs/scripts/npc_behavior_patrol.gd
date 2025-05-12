@tool
extends NPCBehavior

const COLORS = [Color(1,0,0), Color(1,1,0), Color(0,1,0), Color(0,1,1), Color(0,0,1), Color(1,0,1)]

@export var walk_speed: float = 30.0
@onready var timer: Timer = $Timer

#This is our patrol locations
var patrol_locations : Array[PatrolLocation]
#current location of NPC
var current_location_index: int = 0
#Where NPC is going
var target : PatrolLocation
var has_started:bool = false
var last_phase: String = ""
var direction: Vector2


func _ready() -> void:
	gather_patrol_locations()
	
	if Engine.is_editor_hint():
		child_entered_tree.connect(gather_patrol_locations)
		child_order_changed.connect(gather_patrol_locations)
		return
	super()
	#if no patrol locations
	if patrol_locations.size() == 0:
		#we are stopping the process
		process_mode = Node.PROCESS_MODE_DISABLED
		return
	target = patrol_locations[ 0 ]
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
		#checking everyt tick how close the npc is to the target
	if npc.global_position.distance_to(target.target_position) < 1:
		idle_phase()
	
	#adding the Node parameter because child_entered_tree requires it but we will never use it
func gather_patrol_locations(_n: Node = null)->void:
	#If there is some trash in the array toss it out
	patrol_locations = []
	#looping through the children of the node
	for c in get_children():
		#is it a patrol location?
		if c is PatrolLocation:
			#must be a patrol locations let's add it to the array
			patrol_locations.append(c)
			
	if Engine.is_editor_hint():
		if patrol_locations.size() > 0:
			for i in patrol_locations.size():
				var _p = patrol_locations[i] as PatrolLocation
				
				if not _p.transform_changed.is_connected(gather_patrol_locations):
					_p.transform_changed.connect(gather_patrol_locations)
				
				_p.update_label(str(i))
				_p.modulate = _get_color_by_index(i)
				
				var _next : PatrolLocation
				if i < patrol_locations.size() - 1:
					_next = patrol_locations[i+1]
				else:
					_next = patrol_locations[0]
				_p.update_line(_next.position)
			
	
func start()->void:
	#So if the behavior is not enabled, do nothing, 
	#but if there are not at least 2 patrol locations, can't go either
	if npc.do_behavior_enabled == false or patrol_locations.size()< 2:
		return
	#if the walk/idle phase has already started
	if has_started == true:
		#is there still time left on the timer, if there is still in idle phase
		if timer.time_left == 0:
			#if idle phase has already completed, let's go ahead and walk
			walk_phase()
		#already idling so just returning to the idle 
		return
	
	has_started = true	
	
	idle_phase()
	
	

func idle_phase()->void:
	#idle
	npc.global_position = target.target_position
	npc.state = "idle"
	npc.velocity = Vector2.ZERO
	npc.update_animation()
	
	var wait_time : float = target.wait_time
	
	current_location_index += 1
	if current_location_index >= patrol_locations.size():
		current_location_index = 0
		
	target = patrol_locations[current_location_index]
	
	if wait_time > 0:
		timer.start(wait_time)
		await timer.timeout
	
	if npc.do_behavior_enabled == false:
		return
	walk_phase()
	
func walk_phase()->void:
		#setting the state to walk after the timer for the idle is over
	npc.state = "walk"
	#setting the target position to a variable
	direction = global_position.direction_to(target.target_position)
	#setting the variable position to the npcs direction variable
	npc.direction = direction
	#setting the speed of the npc walking
	npc.velocity = walk_speed * direction
	#updating the direction of the npc
	npc.update_direction(target.target_position)
	#updating the npc animation to show walking
	npc.update_animation()
	pass

func _get_color_by_index(i: int)->Color:
	var color_count: int = COLORS.size()
	while i > color_count-1:
		i -= color_count
	return COLORS[i]
		
	
	
	
