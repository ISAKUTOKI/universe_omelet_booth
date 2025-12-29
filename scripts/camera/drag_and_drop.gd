extends Node
@onready var camera: Camera3D = $".."
var is_dragging: bool = false
@export var drag_distance: float = 1.5  # 拖拽时离相机的距离
var mouse_pos
var ray_dir


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		pass

	if is_dragging and event is InputEventMouseMotion:
		#_update_drag_position()
		pass

#func _update_drag_position():
	#if current_card == null:
		#return
	## 计算固定距离的位置
	#mouse_pos = get_viewport().get_mouse_position()
	#ray_dir = camera.project_ray_normal(mouse_pos)
	#current_card.global_position = camera.global_position + ray_dir * drag_distance
	##print(current_card.global_position)
	#current_card.look_at(camera.position, Vector3(0, 1, 0), true)
