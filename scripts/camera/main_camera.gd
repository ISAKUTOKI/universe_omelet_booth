extends Camera3D
## 在此脚本只处理相机的旋转功能与基础属性
## 并且协调子节点

@export_group("相机基础属性")
@export var camera_size: Vector2i = Vector2i(1920, 1080)
@export var camera_sensitivity: int = 40  # 相机灵敏度
@export var camera_fov: int = 95
@export var camera_far: float = 20
var rotation_speed = camera_sensitivity * 0.00005  # 相机旋转速度
var can_rotate_camera: bool = false
var original_pos: Vector3
var original_rot_deg: Vector3

@export_group("相机角度钳制")
@export var camera_angle_limit_x: float = 35  # 上下角度限制(度数)
@export var camera_angle_limit_y: float = 30  # 左右角度限制(度数)

@onready var raycast: RayCast3D = $RayCast
@onready var drag_and_drop: Node = $DragAndDrop


func _ready():
	_intialize_camera()


func _process(_delta: float) -> void:
	pass


func _input(event):
	if event.is_action_pressed("change_camera_rotatable"):
		can_rotate_camera = !can_rotate_camera
	if can_rotate_camera and event is InputEventMouseMotion:
		_rotate_world_y(event)
		_rotate_local_x(event)
		_clamp_rotation()


func _intialize_camera():
	self.fov = camera_fov
	self.far = camera_far
	original_pos = self.position
	original_rot_deg = self.rotation_degrees
	raycast.enabled = true
	add_to_group("Camera")


#region 相机的旋转逻辑
# 沿世界y轴左右旋转
func _rotate_world_y(event):
	rotate_y(event.relative.x * -rotation_speed)


# 沿本地x轴上下旋转
func _rotate_local_x(event):
	rotate_object_local(Vector3(1, 0, 0), event.relative.y * -rotation_speed)


# 钳制旋转
func _clamp_rotation():
	var current_rotation_deg = rotation_degrees
	# 钳制X轴旋转
	current_rotation_deg.x = clamp(
		current_rotation_deg.x,
		original_rot_deg.x - camera_angle_limit_x,
		original_rot_deg.x + camera_angle_limit_x
	)
	# 钳制Y轴旋转
	current_rotation_deg.y = clamp(
		current_rotation_deg.y,
		original_rot_deg.y - camera_angle_limit_y,
		original_rot_deg.y + camera_angle_limit_y
	)
	# 限制z轴保证相机稳定
	current_rotation_deg.z = 0
	# 应用钳制后的旋转
	rotation_degrees = current_rotation_deg


#endregion

#region 相机的选中逻辑
var current_target = null


func _on_raycast_target_changed(new_target):
	if new_target == current_target:
		return
	# 先清除上一个目标的描边
	if current_target != null:
		if current_target.has_method("mouse_exited"):
			current_target.mouse_exited()
	# 设置新目标
	current_target = new_target
	# 对新目标显示描边
	if current_target != null:
		if current_target.has_method("mouse_entered"):
			current_target.mouse_entered()


#endregion
