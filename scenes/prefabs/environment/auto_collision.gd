extends MeshInstance3D

enum CollisionType {
	SIMPLE_CONVEX,
	CONVEX,
	MULTIPLE_CONVEX,
	TRIMESH,
}

@export var type := CollisionType.CONVEX


func _ready() -> void:
	match type:
		CollisionType.SIMPLE_CONVEX:
			create_convex_collision(true, true)
		CollisionType.CONVEX:
			create_convex_collision()
		CollisionType.MULTIPLE_CONVEX:
			create_multiple_convex_collisions()
		CollisionType.TRIMESH:
			create_trimesh_collision()
