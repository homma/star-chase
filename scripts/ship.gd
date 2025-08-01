extends RigidBody2D

const config = preload("res://scripts/config.gd")

var k_thrust = config.thrust
var k_torque = config.torque

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:

    var turn = Input.get_axis("turn_left", "turn_right")
    var thrust = Input.is_action_pressed("thrust")

    var force = Vector2.ZERO
    if thrust:
        force = - transform.y * k_thrust

    var torque = turn * k_torque

    state.apply_force(force)
    state.apply_torque(torque)
