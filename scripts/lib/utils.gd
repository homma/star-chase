
# return a project setting value
static func get_project_setting(path):
    return ProjectSettings.get_setting(path)

# update a project setting value
static func set_project_setting(path, value):
    ProjectSettings.set_setting(path, value)
    ProjectSettings.save()

# create a node for a given class name
static func create_node(name: StringName):
    return ClassDB.instantiate(name)

# create a scene from a node
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

# load scene from a path and create instance
static func load_scene(path):
    return load(path).instantiate()

# add a child node to a parent
static func add_child(parent, child):
    parent.add_child(child)

    var owner = parent.get_owner()
    if owner:
        child.set_owner(owner)
    else:
        child.set_owner(parent)

# add a node to a scene
static func add_to_scene(root, parent, child):
    parent.add_child(child)
    child.set_owner(root)
