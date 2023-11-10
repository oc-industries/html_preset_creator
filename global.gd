extends Node

var app_name = ProjectSettings.get("application/config/name")
var version = "1.1"
var version_msg = "Second Release"

var author = "OC Industries"
var website_domain = "http://ocdev.rf.gd"

var year_the_product_released = 2023
var current_year = OS.get_datetime().year
var copyright = current_year + 1

func _ready():
	print(app_name, ": Version: ", version, " ", version_msg)
	print(str(author, " - Copyright: ", year_the_product_released,  " - ", copyright))
	# Dirty way to copyright forever lmao
	get_node("/root/main/info").play_info(str(version, " ", version_msg, " : ", author, " - Copyright: ", year_the_product_released,  " - ", copyright))
