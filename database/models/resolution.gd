class_name Resolution


var id: int
var width: int
var height: int


func _to_string() -> String:
    return "(%d, %d, %d)" % [id, width, height]
