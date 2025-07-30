extends Camera3D
class_name conquest_camera
## Script that controls camera movement when in a conquest battle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

## How fast the camera moves when dragged
@export var _drag_speed:float = .25
## If the camera is acrivly being dragged
var _dragging:bool = false
## How the fast the camera is moving when not being dragged
var _camera_velocity:Vector2 = Vector2.ZERO
## How fast the camera slows down
const _camera_stop_speed:float = 0.01

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and event.button_mask == MOUSE_BUTTON_MASK_LEFT:
		_dragging = true
		var _mouse_movement:Vector2 = event.relative.normalized() * _drag_speed
		self.position.x -= _mouse_movement.x
		self.position.z -= _mouse_movement.y
		
		_camera_velocity = _mouse_movement
	elif _dragging:
		_dragging = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !_dragging and _camera_velocity.abs() > Vector2.ZERO:
		_camera_velocity = _camera_velocity.move_toward(Vector2.ZERO, _camera_stop_speed)
		self.position.x -= _camera_velocity.x
		self.position.z -= _camera_velocity.y
