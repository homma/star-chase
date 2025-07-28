
const utils = preload("res://scripts/lib/utils.gd")

const stage_size = Vector2(20000, 20000)

# Entry Point

static func run():
    create_main_scene()

# Scene

static func get_viewport_size() -> Vector2:

    var viewport_width = "display/window/size/viewport_width"
    var viewport_height = "display/window/size/viewport_height"

    var w = utils.get_project_setting(viewport_width)
    var h = utils.get_project_setting(viewport_height)

    return Vector2(w, h)

static func create_main_scene():

    # root node
    var root = utils.create_node("Node2D")
    root.set_name("root")
    root.show()

    # stage node
    var stage_path = create_stage_scene()
    var stage = utils.load_scene(stage_path)
    utils.add_child(root, stage)

    # ship node
    var ship_path = create_ship_scene()
    var ship = utils.load_scene(ship_path)

    ship.set_position(stage_size / 2)

    utils.add_child(root, ship)

    return utils.create_scene_from_node(root, "root")

static func create_stage_scene():

    # root node
    var stage = utils.create_node("Node2D")
    stage.set_name("stage")
    stage.show()

    # background color rect
    var bg = utils.create_node("ColorRect")
    bg.set_name("background")
    bg.set_color(Color.BLACK)
    bg.set_size(stage_size)
    ## bg.set_anchors_preset(Control.LayoutPreset.PRESET_FULL_RECT)
    utils.add_child(stage, bg)

    # particles
    var stars = utils.create_node("GPUParticles2D")
    stars.set_name("stars")

    stars.set_amount(20000)
    stars.set_lifetime(30)

    var rect = Rect2(0, 0, stage_size.x, stage_size.y)
    stars.set_visibility_rect(rect)

    ## material
    var material = ParticleProcessMaterial.new()
    var shape = ParticleProcessMaterial.EmissionShape.EMISSION_SHAPE_BOX
    material.set_emission_shape(shape)
    material.set_emission_box_extents(Vector3(20000, 20000, 1))
    material.set_gravity(Vector3.ZERO)
    material.set_param_min(ParticleProcessMaterial.Parameter.PARAM_SCALE, 2)
    material.set_param_max(ParticleProcessMaterial.Parameter.PARAM_SCALE, 5)
    stars.set_process_material(material)

    utils.add_child(stage, stars)

    # add edges of the stage

    return utils.create_scene_from_node(stage, "stage")

static func create_ship_scene():

    # root node
    var ship = utils.create_node("RigidBody2D")
    ship.set_name("ship")
    ship.set_can_sleep(false)
    ship.set_gravity_scale(0.0)
    ship.set_angular_damp(2.0)
    ship.set_linear_damp(1.0)
    ship.set_script(load("res://scripts/ship.gd"))
    ship.show()

    # add camera
    var camera = utils.create_node("Camera2D")
    utils.add_child(ship, camera)

    # add ship polygon
    var poly = create_ship_polygon()
    utils.add_child(ship, poly)

    # add collision shape
    var col = utils.create_node("CollisionPolygon2D")
    col.set_polygon(poly.get_polygon())
    utils.add_child(ship, col)

    return utils.create_scene_from_node(ship, "ship")

static func create_ship_polygon():

    var poly = utils.create_node("Polygon2D")

    poly.set_name("ship")
    poly.set_color(Color.BLUE)

    # create a shape
    var pt0 = Vector2(0, -30)
    var pt1 = Vector2(-15, 30)
    var pt2 = Vector2(15, 30)
    var arr = PackedVector2Array([pt0, pt1, pt2])
    poly.set_polygon(arr)

    return poly
