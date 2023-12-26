extends Node


## Applies cubic ease in out function.
##
## Input and output range: (0, 1).
## Any input outside this range is clamped to these bounds.
func cubic_ease_in_out(x: float) -> float:
	if x <= 0:
		return 0
	if x >= 1:
		return 1

	return x * x * (3 - 2 * x)
