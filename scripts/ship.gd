extends RigidBody2D

const k_thrust = 3000.0
const k_torque = 2000.0

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:

    var turn = Input.get_axis("turn_left", "turn_right")
    var thrust = Input.is_action_pressed("thrust")

    var force = Vector2.ZERO
    if thrust:
        force = - transform.y * k_thrust

    var torque = turn * k_torque

    state.apply_force(force)
    state.apply_torque(torque)
