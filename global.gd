extends Node

# global.gd file preset, by alex135t

# Go to Project -> Project Settings -> AutoLoad -> Click folder icon
# -> Select global.gd -> Click add and you can now use infos here anywhere!

var app_name = ProjectSettings.get("application/config/name")
var version = "1.0"
var version_msg = "First release!"

var author = "OC Industries"
var website_domain = "http://ocdev.rf.gd"

var year_the_product_released = 2023
var current_year = OS.get_datetime().year
var copyright = current_year + 1


func _ready():
	print(app_name, ": Version: ", version, " ", version_msg)
	print(str(author, " - Copyright: ", year_the_product_released,  " - ", copyright))

