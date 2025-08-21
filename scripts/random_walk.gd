# random walk AI
class_name RandomWalk

const config = preload("res://scripts/config.gd")

var stage_size = config.stage_size
var target_area: Rect2
var target_area_width: float = config.target_area_width
var target_area_height: float = config.target_area_height
var k_thrust: float = config.star_thrust
var k_torque: float = config.star_torque
var speed = 1

var object: Node2D

func _init(p_object: Node2D):
    object = p_object
    make_new_goal()

func make_new_goal() -> void:
    target_area = make_target_area()
    speed = make_speed()

func make_target_area() -> Rect2:
    var viewport_size = object.get_viewport_rect().size

    var min_x = viewport_size.x / 2
    var min_y = viewport_size.y / 2

    var max_x = stage_size.x - viewport_size.x / 2 - target_area_width
    var max_y = stage_size.y - viewport_size.y / 2 - target_area_height

    var x = randf_range(min_x, max_x)
    var y = randf_range(min_y, max_y)

    return Rect2(x, y, target_area_width, target_area_height)

func make_speed() -> float:
    return randf_range(0.6, 0.9)

func update(state: PhysicsDirectBodyState2D):
    if finished():
        make_new_goal()

    move_to_target(state)

func finished() -> bool:
    # if star is in the target area
    return target_area.has_point(object.position)

func move_to_target(state: PhysicsDirectBodyState2D) -> void:
    var target_center = target_area.get_center()
    var perpendicular = PI / 2 # deg_to_rad(90)
    object.rotation = object.position.angle_to_point(target_center) + perpendicular

    var force = Vector2.ZERO
    force = - object.transform.y * k_thrust * speed

    state.apply_force(force)
