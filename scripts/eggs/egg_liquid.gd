extends Node3D
class_name EggLiquid

# 资源
@export var data: EggLiquidStats
# 煎制
var is_frying: bool = false
var current_fry_time: float = 0
var current_flip_index: int = 0
var overtime: float = 0
var lacktime: float = 0


func _ready() -> void:
	if data == null:
		push_warning("未插入data")


func _process(delta: float) -> void:
	if is_frying:
		current_fry_time += delta

	if current_fry_time == data.flip_time[current_flip_index]:
		pass


func put_in():
	# 动画
	pass


func flip():
	# 数据
	is_frying = false
	current_fry_time = 0
	lacktime += max(0, data.flip_time[current_flip_index] - current_fry_time)
	overtime += max(0, current_fry_time - data.flip_time[current_flip_index])
	current_flip_index += 1
	# 动画
	pass


func commit():
	GlobalSignalBus.commit_omelet.emit(data.value, data.type)
	self.queue_free()
	pass
