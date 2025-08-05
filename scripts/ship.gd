extends RigidBody2D

const config = preload("res://scripts/config.gd")
const global = preload("res://scripts/global.gd")

var k_thrust = config.thrust
var k_torque = config.torque

var stage_size = config.stage_size

# func _ready():
#     body_entered.connect(_on_body_entered)
# 
# func _on_body_entered(body):
#     print("ship: body_entered")
#     print(body.name)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:

    var turn = Input.get_axis("turn_left", "turn_right")
    var thrust = Input.is_action_pressed("thrust")

    var force = Vector2.ZERO
    if thrust:
        force = - transform.y * k_thrust

    var torque = turn * k_torque

    state.apply_force(force)
    state.apply_torque(torque)

    wrap_stage_border()

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
    global.ship_position = position
