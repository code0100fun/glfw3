import code0100fun.glfw3 as glfw { GLFWHints, GLFWOpenGLProfile, GLHintValue }
import sokol.gfx
import sokol.sgl

[console]
fn main() {
    mut app := &App{
        width: 800
        height: 800
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
    width       int
    height      int
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

fn (mut app App) init_sg() {
    desc := gfx.Desc{}
    gfx.setup(&desc)
    app.sg_context = gfx.setup_context()
}

fn (mut app App) frame() {
    app.main_window.make_context_current()
    gfx.activate_context(app.sg_context)

    gfx.begin_default_pass(&app.pass_action, app.width, app.height)
    sgl.default_pipeline()

    size := app.main_window.get_framebuffer_size()
    app.width = size.width
    app.height = size.height
    sgl.viewport(0, 0, app.width, app.height, true)
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

    win_opts := glfw.CreateWindowOptions{
        // high dpi
        width: app.width * 2
        height: app.height * 2
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
