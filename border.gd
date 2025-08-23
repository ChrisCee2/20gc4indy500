class_name Border extends StaticBody2D

@export var create_segment_shapes: bool = false
@export var collision_polygon: CollisionPolygon2D
@export var collision_shape: CollisionShape2D
@export var path: Path2D

@export_group("Visuals")
@export var line: Line2D
@export var polygon: Polygon2D


func _ready() -> void:
	var path_points: PackedVector2Array = path.curve.get_baked_points()
	if collision_polygon:
		collision_polygon.polygon = path_points
	if line:
		line.points = path_points
	if polygon:
		polygon.polygon = path_points
	if create_segment_shapes:
		create_segments()


func create_segments() -> void:
	var points: PackedVector2Array = path.curve.get_baked_points()
	for i in range(points.size() - 1):
		var from_point: Vector2 = points[i]
		var to_point: Vector2 = points[i+1]
		
		var segment: CollisionShape2D = CollisionShape2D.new()
		segment.shape = SegmentShape2D.new()
		segment.shape.a = from_point
		segment.shape.b = to_point
		add_child(segment)
		
