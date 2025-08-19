class_name Border extends StaticBody2D

@export var collision_polygon: CollisionPolygon2D
@export var path: Path2D

@export_group("Visuals")
@export var line: Line2D
@export var polygon: Polygon2D


func _ready() -> void:
	var path_points: PackedVector2Array = path.curve.get_baked_points()
	collision_polygon.polygon = path_points
	if line:
		line.points = path_points
	if polygon:
		polygon.polygon = path_points
