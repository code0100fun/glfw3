import code0100fun.glfw3 as glfw { GLFWHints, GLFWOpenGLProfile, GLHintValue, Size }
import sokol.gfx
import sokol.sgl
import gg
import stbi

[console]
fn main() {
    mut app := &App{
        size: Size{800, 800}
        high_dpi: gg.high_dpi()
        main_window: 0
        pass_action: gfx.create_clear_pass(0.1, 0.1, 0.1, 1.0)
    }
    app.init()
    app.run()
    app.destroy()
}

struct App {
    pass_action gfx.PassAction
mut:
    size        Size
    high_dpi    bool
    main_window &glfw.GLFWwindow
    sg_context  gfx.Context
}

pub struct Screenshot {
    width  int
    height int
    size   int
mut:
    pixels &u8
}

fn (mut app App) init() {
    app.init_glfw()
    app.init_sg()

    sgl_desc := sgl.Desc{
        max_vertices: 50 * 65536
    }
    sgl.setup(&sgl_desc)
}

fn (mut app App) destroy() {
    app.main_window.destroy()
    glfw.terminate()
}

fn (mut app App) run() {
    mut window := app.main_window
    window.make_context_current()

    // swap buffers immediatly so only one frame needs to be rendered
    app.main_window.swap_buffers()
    app.frame()

    width := app.size.width
    height := app.size.height
    color_channels := 4
    output_path := 'example/offscreen.png'

    screenshot := screenshot_window(width, height, color_channels)
    stbi.set_flip_vertically_on_write(true)
    stbi.stbi_write_png(output_path, width, height, color_channels, screenshot.pixels,
        width * color_channels) or { panic(err) }
}

pub fn screenshot_window(width int, height int, color_channels int) &Screenshot {
    size := width * height * color_channels
    pixels := unsafe { &u8(malloc(size)) }

    // glReadPixels
    C.v_sapp_gl_read_rgba_pixels(0, 0, width, height, pixels)
    return &Screenshot{
        width: width
        height: height
        size: size
        pixels: pixels
    }
}

fn (app App) window_size() glfw.Size {
    return if app.high_dpi {
        Size{app.size.width * 2, app.size.height * 2}
    } else {
        app.size
    }
}

fn (mut app App) init_sg() {
    desc := gfx.Desc{}
    gfx.setup(&desc)
    app.sg_context = gfx.setup_context()
}

fn (mut app App) frame() {
    app.main_window.make_context_current()
    gfx.activate_context(app.sg_context)

    size := app.main_window.get_framebuffer_size()
    app.size.width = size.width
    app.size.height = size.height

    gfx.begin_default_pass(&app.pass_action, app.size.width, app.size.height)
    sgl.default_pipeline()

    sgl.viewport(0, 0, app.size.width, app.size.height, true)
    draw_triangle()

    sgl.draw()
    gfx.end_pass()
    gfx.commit()
}

fn (mut app App) init_glfw() {
    glfw.glfw_init()
    glfw.window_hint(GLFWHints.version_major, 3)
    glfw.window_hint(GLFWHints.version_minor, 3)
    glfw.window_hint(GLFWHints.opengl_forward_compat, GLHintValue.gl_true)
    glfw.window_hint(GLFWHints.opengl_profile, GLFWOpenGLProfile.core)

    // Set visible = false
    glfw.window_hint(GLFWHints.visible, GLHintValue.gl_false)

    size := app.window_size()
    win_opts := glfw.CreateWindowOptions{
        width: size.width
        height: size.height
        title: 'GLFW Window'
        monitor: 0
        share: 0
    }
    mut window := glfw.create_window(win_opts)
    window.make_context_current()

    glfw.swap_interval(1)
    app.main_window = window
}

pub fn draw_triangle() {
    sgl.defaults()
    sgl.begin_triangles()
    sgl.v2f_c3b(0.0, 0.5, 255, 0, 0)
    sgl.v2f_c3b(-0.5, -0.5, 0, 0, 255)
    sgl.v2f_c3b(0.5, -0.5, 0, 255, 0)
    sgl.end()
}
