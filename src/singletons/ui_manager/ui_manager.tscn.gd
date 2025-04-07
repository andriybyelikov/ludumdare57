extends Control


signal ui_scale_changed


const _INITIAL_SCALE: int = 1


var _base_default_theme: Theme
var _base_custom_theme: Theme
var _current_scale: int


func _ready() -> void:
    $CanvasLayer.visible = false
    
    self._base_default_theme = ThemeDB.get_default_theme().duplicate(true)
    self._base_custom_theme = ThemeDB.get_project_theme().duplicate(true)
    self._current_scale = _INITIAL_SCALE
    
    self.get_tree().root.size_changed.connect(_on_root_window_size_changed)
    
    self._on_root_window_size_changed()


func _on_root_window_size_changed() -> void:
    var auto_scale: int = self._get_auto_scale()
    if auto_scale != self._current_scale:
        self._current_scale = auto_scale
        
        $CanvasLayer.visible = true
        
        # NOTE:
        # As a workaround, here we wait 1 second to make sure that the
        # "Scaling UI, please wait..." text is shown before actual UI scaling begins.
        await self.get_tree().create_timer(1).timeout
        
        self._scale_default_theme(auto_scale)
        self._scale_custom_theme(auto_scale)
        
        $CanvasLayer.visible = false
        
    self.ui_scale_changed.emit()


func _get_auto_scale() -> int:
    var base_height: int = ProjectSettings.get("display/window/size/viewport_height")
    var current_height: int = DisplayServer.window_get_size().y
    return current_height / base_height


func _scale_theme(base_theme: Theme, scaled_theme: Theme, scale: int) -> void:
    for theme_type: String in scaled_theme.get_constant_type_list():
        for constant_name: String in scaled_theme.get_constant_list(theme_type):
            var base: int = base_theme.get_constant(constant_name, theme_type)
            var scaled: int = base * scale
            scaled_theme.set_constant(constant_name, theme_type, scaled)
    
    for theme_type: String in scaled_theme.get_font_size_type_list():
        for font_size_name: String in scaled_theme.get_font_size_list(theme_type):
            var base: int = base_theme.get_font_size(font_size_name, theme_type)
            var scaled: int = base * scale
            scaled_theme.set_font_size(font_size_name, theme_type, scaled)
    
    for theme_type: String in scaled_theme.get_icon_type_list():
        for icon_name: String in scaled_theme.get_icon_list(theme_type):
            var base_icon: Texture2D = base_theme.get_icon(icon_name, theme_type)
            if base_icon is ImageTexture:
                var base_size: Vector2i = base_icon.get_size()
                var scaled_size: Vector2i = base_size * scale
                var scaled_icon: ImageTexture = scaled_theme.get_icon(icon_name, theme_type)
                scaled_icon.set_size_override(scaled_size)
    
    for theme_type: String in scaled_theme.get_stylebox_type_list():
        for stylebox_name: String in scaled_theme.get_stylebox_list(theme_type):
            var base_stylebox: StyleBox = base_theme.get_stylebox(stylebox_name, theme_type)
            var scaled_stylebox: StyleBox = scaled_theme.get_stylebox(stylebox_name, theme_type)
            var stylebox_numeric_properties: Array = base_stylebox.get_property_list().filter(
                func (x: Dictionary):
                    return x["type"] in [
                        Variant.Type.TYPE_INT,
                        Variant.Type.TYPE_FLOAT,
                        Variant.Type.TYPE_VECTOR2,
                    ]
            ).reduce(
                func (accum: Array, x: Dictionary):
                    accum.append(x["name"])
                    return accum,
                []
            )
            for property: StringName in stylebox_numeric_properties:
                var base: Variant = ClassDB.class_get_property(base_stylebox, property)
                var scaled: Variant = base * scale
                ClassDB.class_set_property(scaled_stylebox, property, scaled)


func _scale_default_theme(scale: int) -> void:
    self._scale_theme(_base_default_theme, ThemeDB.get_default_theme(), scale)


func _scale_custom_theme(scale: int) -> void:
    var custom_theme: Theme = ThemeDB.get_project_theme()
    custom_theme.default_font_size = _base_custom_theme.default_font_size * scale
    self._scale_theme(_base_custom_theme, custom_theme, scale)
