extends OptionButton

const RESOLUTIONS : Dictionary[String, Vector2i] = {
	"400 x 225": Vector2i(400, 225),
	"800 x 450": Vector2i(800, 450),
	"1280 x 720": Vector2i(1280, 720),
	"1600 x 900": Vector2i(1600, 900),
	"1920 x 1080": Vector2i(1920, 1080),
	"2560 x 1440": Vector2i(2560, 1440),
	"3200 x 1800": Vector2i(3200, 1800),
	"3840 x 2160": Vector2i(3840, 2160),
}

var base_window_size := Vector2(
	ProjectSettings.get_setting("display/window/size/viewport_width"),
	ProjectSettings.get_setting("display/window/size/viewport_height")
)

func _ready() -> void:
	for resolution in RESOLUTIONS:
		add_item(resolution);

	print("Scaling Factor: %s" % get_window().content_scale_factor);
	print("Scaling Size: %s" % get_window().content_scale_size);


func _on_item_selected(index: int) -> void:
	var new_resolution_string = get_item_text(index);
	var new_resolution : Vector2i = RESOLUTIONS[new_resolution_string];
	# Multiply by the existing scaling factor because otherwise we're going to resize funnily.
	# This only works on the FIRST RESIZE. Something really weird's going on with all of this.
	
	var new_scaling_factor = get_window().content_scale_factor * float(new_resolution.x) / float(get_window().size.x);
	print("Changing Scale Size and Factor to %s and %s from %s and %s:" % [new_resolution, new_scaling_factor, get_window().content_scale_size, get_window().content_scale_factor]);
	get_window().content_scale_size = new_resolution;
	get_window().content_scale_factor = new_scaling_factor;

	print("Window Size: %s" % get_window().size);
	print("Window is Window Viewport: %s" % (get_window() == get_window().get_viewport()));
	print("Scaling Factor: %s" % get_window().content_scale_factor);
	print("Scaling Size: %s" % get_window().content_scale_size);
