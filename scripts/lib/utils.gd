
# project setting

## return a project setting value
static func get_project_setting(path):
    return ProjectSettings.get_setting(path)

## update a project setting value
static func set_project_setting(path, value):
    ProjectSettings.set_setting(path, value)
    ProjectSettings.save()

# scene

## create a node for a given class name
static func create_node(name: StringName):
    return ClassDB.instantiate(name)

## create a scene from a node
static func create_scene_from_node(root_node, scene_name):
    # PackedScene
    var scn = PackedScene.new()
    scn.pack(root_node)

    # generate a file path to store a scene
    var path = "res://" + scene_name + ".tscn"

    var n = 0
    while FileAccess.file_exists(path):
        n += 1
        path = "res://" + scene_name + str(n) + ".tscn"

    # save the PackedScene
    ResourceSaver.save(scn, path)

    # open the PackedScene in the editor
    EditorInterface.open_scene_from_path(path)

    return path

## load scene from a path and create instance
static func load_scene(path):
    return load(path).instantiate()

## add a child node to a parent
static func add_child(parent, child):
    parent.add_child(child)

    var owner = parent.get_owner()
    if owner:
        child.set_owner(owner)
    else:
        child.set_owner(parent)

## add a node to a scene
static func add_to_scene(root, parent, child):
    parent.add_child(child)
    child.set_owner(root)

# shapes

## Line

static func create_line(x0: float, y0: float, x1: float, y1: float, thickness, color):
    var line = create_node("Line2D")

    line.set_closed(false)
    line.set_default_color(color)
    line.set_width(thickness)

    var p0 = Vector2(x0, y0)
    var p1 = Vector2(x1, y1)
    var points = PackedVector2Array([p0, p1])
    line.set_points(points)

    return line

## rectangle

static func create_rectangle(x: float, y: float, width: float, height: float, color: Color) -> Polygon2D:
    var rect = create_node("Polygon2D")

    rect.set_color(color)

    var p0 = Vector2(x, y)
    var p1 = p0 + Vector2(width, 0)
    var p2 = p0 + Vector2(width, height)
    var p3 = p0 + Vector2(0, height)
    var points = PackedVector2Array([p0, p1, p2, p3])
    rect.set_polygon(points)

    return rect

static func create_rectangle_lines(x: float, y: float, width: float, height: float, thickness: float, color: Color) -> Line2D:
    var rect = create_node("Line2D")

    rect.set_closed(true)
    rect.set_default_color(color)
    rect.set_width(thickness)

    var p0 = Vector2(x, y)
    var p1 = p0 + Vector2(width, 0)
    var p2 = p0 + Vector2(width, height)
    var p3 = p0 + Vector2(0, height)
    var points = PackedVector2Array([p0, p1, p2, p3])
    rect.set_points(points)

    return rect

## triangle

static func create_triangle(p0: Vector2, p1: Vector2, p2: Vector2, color: Color) -> Polygon2D:
    var tri = create_node("Polygon2D")

    tri.set_color(color)

    var points = PackedVector2Array([p0, p1, p2])
    tri.set_polygon(points)

    return tri

static func create_triangle_lines(p0: Vector2, p1: Vector2, p2: Vector2, thickness: float, color: Color) -> Line2D:
    var tri = create_node("Line2D")

    tri.set_closed(true)
    tri.set_sharp_limit(100)
    tri.set_default_color(color)
    tri.set_width(thickness)

    var points = PackedVector2Array([p0, p1, p2])
    tri.set_points(points)

    return tri

## circle

static func create_circle(x: float, y: float, radius: float, divide: int, color: Color) -> Polygon2D:
    var circle = create_node("Polygon2D")

    circle.set_color(color)

    if divide < 3:
        divide = 3

    var arr = []
    for i in range(divide):
        var theta = deg_to_rad(360 / divide) * i
        var cx = x + cos(theta) * radius
        var cy = y + sin(theta) * radius
        arr.push_back(Vector2(cx, cy))

    var points = PackedVector2Array(arr)

    circle.set_polygon(points)

    return circle

static func create_circle_lines(x: float, y: float, radius: float, divide: int, thickness: float, color: Color) -> Line2D:
    var circle = create_node("Line2D")

    circle.set_closed(true)
    # circle.set_sharp_limit(100)
    circle.set_default_color(color)
    circle.set_width(thickness)

    if divide < 3:
        divide = 3

    var arr = []
    for i in range(divide):
        var theta = deg_to_rad(360 / divide) * i
        var cx = x + cos(theta) * radius
        var cy = y + sin(theta) * radius
        arr.push_back(Vector2(cx, cy))

    var points = PackedVector2Array(arr)

    circle.set_points(points)

    return circle

## capsule
