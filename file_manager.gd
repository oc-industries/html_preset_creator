extends Node

onready var main = get_node("/root/main")

var current_path = ""

var config = ConfigFile.new()
var config_app = ConfigFile.new()

func _ready():
	load_app()


func get_main():
	main = get_node("/root/main")

func save_html():
	get_main()
	main.update_var()
	
	var page_name_str = str("<title>", main.page_name, "</title>")
	var css_str = str("<link rel=\"stylesheet\" href=\'", main.css, "'\">")
	var js_str = str("<script src='", main.js, "'></script>")
	
	if main.save_css_path == false:
		css_str = ""
	
	if main.save_page_name == false:
		page_name_str = ""
	
	if main.save_js_path == false:
		js_str = ""
	
	var content = str(
		page_name_str,"\n",
		css_str,"\n",
		
		main.meta, "\n", main.head, "\n ", 
"""
<!--Page Content:-->



<!--Page Content End-->
""", "\n ",main.foot)
	
	var dir = str(main.save_dir, "/", main.save_name, ".html")
	
	var file = File.new()
	file.open(str(dir), file.WRITE)
	file.store_string(content)
	file.close()
	
	
	print(dir)
	main.get_node("info").play_info(str("Save to html at: ", dir))
	

func save_preset():
	get_main()
	main.update_var()
	
	config.set_value("data", "metadata", main.meta)
	config.set_value("data", "header", main.head)
	config.set_value("data", "footer", main.foot)
	config.set_value("data", "pagename", main.page_name)
	config.set_value("data", "css", main.css)
	config.set_value("data", "js", main.js)
	config.set_value("data", "info", main.info)
	
	config.set_value("readme", "copyright", "Copyright 2023 - 2025 OC Industries Game Dev")
	
	var dir = str(main.save_dir, "/", main.save_name, ".hpc")
	print(dir)
	config.save(dir)
	
	main.get_node("info").play_info(str("Save Preset at: ", dir))
	

func load_preset(path):
	get_main()
	config.load(path)
	main.get_node("TabContainer/Metadata/code").text = config.get_value("data", "metadata")
	main.get_node("TabContainer/Header/code").text = config.get_value("data", "header")
	main.get_node("TabContainer/Footer/code").text = config.get_value("data", "footer")
	main.get_node("TabContainer/General Settings/css").text = config.get_value("data", "css")
	main.get_node("TabContainer/General Settings/pagename").text = config.get_value("data", "pagename")
	main.get_node("TabContainer/General Settings/preset_info").text = config.get_value("data", "info")
	main.update_var()
	
	main.get_node("info").play_info(str("Loaded Preset from: ", path))
	

func save_app():
	
	config_app.set_value("DATA", "LAST_DIR", current_path)
	config_app.save("res://app_settings.cfg")
	
	

func load_app():
	
	config_app.load("res://app_settings.cfg")
	
	if config_app.get_value("DATA", "LAST_DIR") == null:
		pass
	else:
		current_path = config_app.get_value("DATA", "LAST_DIR")

