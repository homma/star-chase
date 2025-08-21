extends RigidBody2D

const config = preload("res://scripts/config.gd")
const global = preload("res://scripts/global.gd")

var stage_size = config.stage_size
var random_walk: RandomWalk

func move_to_random_position():
    var x = randf_range(0, stage_size.x)
    var y = randf_range(0, stage_size.y)
    position = Vector2(x, y)
    global.star_position = position

    wrap_stage_border()

func _ready():
    move_to_random_position()
    random_walk = RandomWalk.new(self)

func _on_body_entered(body):
    if body.name == "ship":
        move_to_random_position()

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
    random_walk.update(state)
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
    global.star_position = position
