extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$vbox/product_tab/info.text = Global.app_name
	$vbox/version_tab/info.text = Global.version
	$vbox/version_tab/info_msg.text = Global.version_msg
	$vbox/author_tab/info.text = Global.author
	$vbox/author_tab/info_web.text = Global.website_domain
	$vbox/copyright_tab/year_1.text = str(Global.year_the_product_released)
	$vbox/copyright_tab/year_2.text = str(Global.copyright)



