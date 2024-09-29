extends MovementController

func get_direction() -> Vector2:
	var direction: Vector2 = Vector2(0,0)
	if %MoveLeftButton.button_pressed:
		direction.x -= 1
	if %MoveRightButton.button_pressed:
		direction.x += 1
	if %MoveUpButton.button_pressed:
		direction.y -= 1
	if %MoveDownButton.button_pressed:
		direction.y += 1
	return direction.normalized()
