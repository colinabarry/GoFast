extends Node


func vec2_to_vec3(vec3: Vector3, axis):
	var array = [vec3.x, vec3.y, vec3.z]
	array.remove(axis)
	return Vector2(array[0], array[1])


func vec3_to_vec2(vec2, axis, value):
	var array = [vec2.x, vec2.y]
	array.insert(axis, value)
	return Vector3(array[0], array[1], array[2])

func cubic_ease_in_out(x: float) -> float:
	return x * x * (3 - 2 * x)

func ease_quart(value: float) -> float:
	var result := 0.0
	if value <= 0.0:
		return 0.0

	if value < 0.5:
		result = 8 * value * value * value * value
	else:
		result = 1 - pow(-2 * value + 2, 4) / 2

	return result