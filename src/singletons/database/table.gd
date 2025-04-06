class_name DatabaseTable


var _id_count: int
var _data: Array[Object]
var _index: Dictionary[int, Object]


func _init() -> void:
    self._id_count = 1
    self._data = []
    self._index = {}


func insert(row: Object) -> int:
    row.id = self._id_count
    self._id_count = self._id_count + 1
    self._data.append(row)
    self._index[row.id] = row
    return row.id


func all() -> Array[Object]:
    return self._data


func find(id: int) -> Object:
    return self._index[id]


func where(condition: Callable) -> Array[Object]:
    return self._data.filter(condition)


func delete(id: int) -> void:
    var row: Object = self.find(id)
    self._data.erase(row)
    self._index.erase(id)


func _to_string() -> String:
    return "[%s]" % ", ".join(self._data)
