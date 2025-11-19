# Godot-Viewport-Scaling-Testing
itt we demonstrate why rendering at a different resolution and scaling is complicated

Posted to the Godot Discord.

# Goal

Render at a lower resolution, scale that image up. Intended to boost performance on very weak hardware, like my little laptop (think Chromebook power levels) that can't run my 2d game >10fps without running it at a very low resolution.

# Problem

Viewport mode doesn't actually change the rendered resolution, CanvasItem mode renders at Window size regardless of finagling.

# Test project here:

[github](https://github.com/Kairuni/Godot-Viewport-Scaling-Testing)

# Diving In

According to the documentation on the Window class, [content_scale_size](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-content-scale-size) should indicate the base resolution the nodes inside the window should be drawn at, and [content_scale_factor](https://docs.godotengine.org/en/stable/classes/class_window.html#class-window-property-content-scale-factor) is the ratio between the window's actual size and the base resolution.

If the project is set to viewport stretch mode, we get the following: (Images 1-3)
400x225, 1 scale
800x450, 2 scale
1600x900, 4 scale

As it might not be immediately clear what's going on here, compare the number and position of visible pixels in the text. Effectively, each of these is the same number of visible pixels.

So, this... kinda works. But it doesn't really let us change the resolution of the rendered scene. It shows the same pixels in worldspace in more screen pixels, but it does not show more world pixels.

Let's try adjusting content_scale_size and content_scale_factor.

Let's say I'm looking at a 1600x900 window at 4 scale right now. Let's try doubling 1600x900 and halving the scale factor (Before: image 4, after: image 5) - 3200x1800 is a weird resolution, but we're keeping the numbers clean for now. This will hopefully get us a slightly higher resolution in the same space, showing more of the text and more pixels from the Godot icon.

According to the console, success!

```
Changing Scale Size and Factor to (3200, 1800) and 8.0 from (1600, 900) and 4.0:
Window Size: (1600, 900)
Window is Window Viewport: true
Scaling Factor: 8.0
Scaling Size: (3200, 1800)
```

... But those two images look exactly the same?

And even if they didn't look exactly the same, how do I actually get 8.0 from 3200x1800 and 1600x900?

So, viewport mode isn't working as I'd like for this. Worse, switching to CanvasItem mode causes everything to render at the size of the window regardless of what I do with the scaling factor and scaling size.

Any ideas other than 'use your own viewport for more control'? It seems like Window isn't actually working as described, and there doesn't seem like an easy way to change the base resolution.

Is there something simple that I've missed?

I can probably make something work with my own viewport, but adding another viewport on top of the window and then forcing everything in the scene tree to be inside of it feels... a bit scuffed. I can certainly do it, but I'd rather not.

This is really only to support some of the really weak hardware options, but not everyone has even a 1080.