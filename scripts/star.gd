extends RigidBody2D

const config = preload("res://scripts/config.gd")
const global = preload("res://scripts/global.gd")

var stage_size = config.stage_size

func move_to_random_position():
    var x = randf_range(0, stage_size.x)
    var y = randf_range(0, stage_size.y)
    position = Vector2(x, y)
    global.star_position = position

    wrap_stage_border()

func _ready():
    move_to_random_position()
    rw_init()

func _on_body_entered(body):
    if body.name == "ship":
        move_to_random_position()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
    rw_update(state)
    # wrap_stage_border()

func wrap_stage_border():
    # jump to the other side when it crosses the stage border

    var viewport_size = get_viewport_rect().size

    var min_x = viewport_size.x / 2
    var max_x = stage_size.x - viewport_size.x / 2
    position.x = wrapf(position.x, min_x, max_x)

    var min_y = viewport_size.y / 2
    var max_y = stage_size.y - viewport_size.y / 2
    position.y = wrapf(position.y, min_y, max_y)

    # update global state
    global.star_position = position

# random walk

var target_area: Rect2
var target_area_width: float = config.target_area_width
var target_area_height: float = config.target_area_height
var k_thrust: float = config.star_thrust
var k_torque: float = config.star_torque
var speed = 1

func rw_init():
    make_new_goal()

func make_new_goal():
    target_area = make_target_area()
    speed = make_speed()

func make_target_area() -> Rect2:
    var viewport_size = get_viewport_rect().size

    var min_x = viewport_size.x / 2
    var min_y = viewport_size.y / 2

    var max_x = stage_size.x - viewport_size.x / 2 - target_area_width
    var max_y = stage_size.y - viewport_size.y / 2 - target_area_height

    var x = randf_range(min_x, max_x)
    var y = randf_range(min_y, max_y)

    return Rect2(x, y, target_area_width, target_area_height)

func make_speed() -> float:
    return randf_range(0.6, 0.9)

func rw_update(state: PhysicsDirectBodyState2D):
    if rw_validate():
        make_new_goal()
        move_to_target(state)
    else:
        move_to_target(state)

func rw_validate() -> bool:
    # if star is in the target area
    return target_area.has_point(position)

func move_to_target(state: PhysicsDirectBodyState2D) -> void:
    var target_center = target_area.get_center()
    var perpendicular = PI / 2 # deg_to_rad(90)
    rotation = position.angle_to_point(target_center) + perpendicular

    var force = Vector2.ZERO
    force = - transform.y * k_thrust * speed

    state.apply_force(force)

    wrap_stage_border()
