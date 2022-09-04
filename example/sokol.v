import code0100fun.glfw3 as glfw { GLFWHints, GLFWOpenGLProfile, GLHintValue, Size }
import sokol.gfx
import sokol.sgl
import gg

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
    mut run := true
    for run {
        glfw.poll_events()
        mut window := app.main_window
        window.make_context_current()

        app.frame()

        if window.should_close() {
            run = false
        }
    }
}

fn (app App) window_size() Size {
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

    app.main_window.swap_buffers()
}

fn (mut app App) init_glfw() {
    glfw.glfw_init()
    glfw.window_hint(GLFWHints.version_major, 3)
    glfw.window_hint(GLFWHints.version_minor, 3)
    glfw.window_hint(GLFWHints.opengl_forward_compat, GLHintValue.gl_true)
    glfw.window_hint(GLFWHints.opengl_profile, GLFWOpenGLProfile.core)
    size := app.window_size()
    win_opts := glfw.CreateWindowOptions{
        width: size.width
        height: size.height
        title: 'GLFW Window'
        monitor: 0
        share: 0
    }
    mut window := glfw.create_window(win_opts)
    window.set_user_pointer(&app)
    window.set_key_callback(handle_key_events)
    window.set_cursor_pos_callback(handle_cursor_pos_events)
    window.set_mouse_button_callback(handle_mouse_button_events)
    window.make_context_current()
    window.set_pos(100, 100)

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

fn handle_key_events(window &glfw.GLFWwindow, key int, scancode int, action int, mods int) {
    mut app := get_window_app(window)

    // Handle event with app context
}

fn handle_cursor_pos_events(window &glfw.GLFWwindow, xpos f64, ypos f64) {
    mut app := get_window_app(window)

    // Handle event with app context
}

fn handle_mouse_button_events(window &glfw.GLFWwindow, button int, action int, mods int) {
    mut app := get_window_app(window)

    // Handle event with app context
}

fn get_window_app(window &glfw.GLFWwindow) &App {
    return &App(window.get_user_pointer())
}
