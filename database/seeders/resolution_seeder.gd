class_name ResolutionSeeder
extends DatabaseSeeder


func _seed() -> void:
    var row: Resolution
    
    #region 16:9
    
    row = Resolution.new()
    row.width = 960
    row.height = 540
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 1280
    row.height = 720
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 1360
    row.height = 768
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 1366
    row.height = 768
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 1600
    row.height = 900
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 1920
    row.height = 1080
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 2560
    row.height = 1440
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 3840
    row.height = 2160
    DB.table("resolution").insert(row)
    
    #endregion
    
    #region 16:10
    
    row = Resolution.new()
    row.width = 960
    row.height = 600
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 1280
    row.height = 800
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 1440
    row.height = 900
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 1680
    row.height = 1050
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 1920
    row.height = 1200
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 2560
    row.height = 1600
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 2880
    row.height = 1800
    DB.table("resolution").insert(row)
    
    #endregion
    
    #region 21:9
    
    row = Resolution.new()
    row.width = 1280
    row.height = 540
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 2560
    row.height = 1080
    DB.table("resolution").insert(row)
    
    row = Resolution.new()
    row.width = 3440
    row.height = 1440
    DB.table("resolution").insert(row)
    
    #endregion
