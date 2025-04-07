class_name OptionsPersistence


const _PATH: String = "user://options.cfg"


static \
func load() -> OptionsModel:
    var model: OptionsModel = OptionsModel.new()
    
    var config_file: ConfigFile = ConfigFile.new()
    if config_file.load(_PATH) == OK:
        model.full_screen = config_file.get_value(
            "video",
            "full_screen",
            false
        ) as bool
        model.windowed_resolution_id = config_file.get_value(
            "video",
            "windowed_resolution_id",
            1
        ) as int
        model.vertical_sync = config_file.get_value(
            "video",
            "vertical_sync",
            true
        ) as bool
    
    return model


static \
func save(model: OptionsModel) -> void:
    var config_file: ConfigFile = ConfigFile.new()
    config_file.set_value(
        "video",
        "full_screen",
        model.full_screen
    )
    config_file.set_value(
        "video",
        "windowed_resolution_id",
        model.windowed_resolution_id
    )
    config_file.set_value(
        "video",
        "vertical_sync",
        model.vertical_sync
    )
    
    config_file.save(_PATH)
