extends Node


var _tables: Dictionary[String, DatabaseTable]


func _init() -> void:
    self._tables = {}
    self._tables["aspect_ratio"] = DatabaseTable.new()
    self._tables["resolution"] = DatabaseTable.new()
    self._tables["dialog_text"] = DatabaseTable.new()
    self._tables["npc_story_dialog"] = DatabaseTable.new()


func _ready() -> void:
    var seeder_paths: Array = ProjectSettings.get_global_class_list().filter(
        func (x):
            return x["base"] == "DatabaseSeeder"
    ).reduce(
        func (accum, x):
            accum.append(x["path"])
            return accum,
        []
    )
    
    for path: String in seeder_paths:
        var seeder: DatabaseSeeder = load(path).new() as DatabaseSeeder
        seeder._seed()
    
    # TODO: Remove before release
    print(self._tables)


func table(table_name: String):
    return self._tables[table_name]
