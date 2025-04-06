class_name AspectRatioSeeder
extends DatabaseSeeder


func _seed() -> void:
    var row: AspectRatio
    
    row = AspectRatio.new()
    row.label = "Other"
    row.classification = 0
    DB.table("aspect_ratio").insert(row)
    
    row = AspectRatio.new()
    row.label = "16:9"
    row.classification = float(16) / 9
    DB.table("aspect_ratio").insert(row)
    
    row = AspectRatio.new()
    row.label = "16:10"
    row.classification = float(16) / 10
    DB.table("aspect_ratio").insert(row)
    
    row = AspectRatio.new()
    row.label = "21:9"
    row.classification = float(21) / 9
    DB.table("aspect_ratio").insert(row)
