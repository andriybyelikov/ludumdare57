class_name AspectRatio


const _CLASSIFICATION_EPSILON: float = 0.1
const ASPECT_RATIO_OTHER_ID: int = 1


var id: int
var label: String
var classification: float


func _to_string() -> String:
    return "(%d, \"%s\", %f)" % [id, label, classification]


static \
func classify(resolution: Resolution) -> int:
    var a: float = float(resolution.width) / resolution.height
    for aspect_ratio: AspectRatio in DB.table("aspect_ratio").all():
        if abs(a - aspect_ratio.classification) < _CLASSIFICATION_EPSILON:
            return aspect_ratio.id
    return ASPECT_RATIO_OTHER_ID
