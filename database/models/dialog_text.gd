class_name DialogText


var id: int
var text: String
var next_dialog_text_id: int


func _to_string() -> String:
    return "(%d, \"%s\", %d)" % [id, text, next_dialog_text_id]
