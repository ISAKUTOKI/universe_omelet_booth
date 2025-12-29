extends Resource
class_name EggLiquidStats

enum EggLiquidType { Test, Earth, Mars }

@export_category("Type")
@export var type: EggLiquidType
@export var type_name: String
@export_category("BaseData")
@export var value: int
@export var flip_count: int
@export var flip_time: Array[float]
@export var keep_time: float
@export_category("VisualData")
@export var model: ArrayMesh
