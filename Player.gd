extends Spatial

var rotx = 0.0
var roty = 0.0
export var mouse_sensitivity = 0.01
export var max_speed = 10.0
export var jump_force = 10.0
var double_jump = true
var spawn_point = Vector3()
var coins = 0

func add_coin():
	coins += 1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spawn_point = $Ball.translation

func _process(delta):
	$Camera.rotation = Vector3(roty,rotx,0.0)
	$Camera.translation = $Ball.translation + Vector3(0,0,4).rotated(Vector3(1,0,0),roty).rotated(Vector3(0,1,0),rotx)
	$RayCast.translation = $Ball.translation
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_mouse_button_pressed(1):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Control/Label.text = "Coins: " + str(coins)
	
func _physics_process(delta):
	var direction = Vector3()
	if Input.is_action_pressed("Forwards"):
		direction.z -= 1
	if Input.is_action_pressed("Backwards"):
		direction.z += 1
	if Input.is_action_pressed("Left"):
		direction.x -= 1
	if Input.is_action_pressed("Right"):
		direction.x += 1
	direction = direction.rotated(Vector3(0,1,0), rotx)
	if direction != Vector3():
		direction = direction.normalized()
	
	$Ball.add_central_force(direction * 40)
	$Ball.add_central_force(Vector3($Ball.linear_velocity.x,0.0,$Ball.linear_velocity.z)*-2)
	var speed = Vector2($Ball.linear_velocity.x,$Ball.linear_velocity.z).length()
	if speed > max_speed:
		$Ball.add_central_force(Vector3($Ball.linear_velocity.x,0.0,$Ball.linear_velocity.z)*-10)
	print(speed)
	if Input.is_action_just_pressed("Jump") and ($RayCast.is_colliding() or double_jump):
		$Ball.linear_velocity.y = jump_force
		double_jump = false
	if $RayCast.is_colliding():
		double_jump = true
	if $Ball.translation.y < -10:
		$Ball.translation = spawn_point

func _input(event):
	if event is InputEventMouseMotion:
		rotx -= event.relative.x * mouse_sensitivity
		if roty - event.relative.y * mouse_sensitivity < PI/2 and roty - event.relative.y * mouse_sensitivity > -PI/2:
			roty -= event.relative.y * mouse_sensitivity
