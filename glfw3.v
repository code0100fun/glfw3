module glfw3

pub fn glfw_init() {
    C.glfwInit()
}

pub fn swap_interval(interval int) {
    C.glfwSwapInterval(interval)
}

pub fn poll_events() {
    C.glfwPollEvents()
}

pub fn terminate() {
    C.glfwTerminate()
}

pub fn window_hint(hint GLFWHints, value GLFWHintValue) {
    val := match value {
        int { value as int }
        GLHintValue { int(value) }
        GLFWOpenGLProfile { int(value) }
    }
    C.glfwWindowHint(int(hint), val)
}

pub fn create_window(options CreateWindowOptions) &GLFWwindow {
    return C.glfwCreateWindow(options.width, options.height, options.title.str, options.monitor,
        options.share)
}

pub fn get_current_context() &GLFWwindow {
    return C.glfwGetCurrentContext()
}

pub fn (window &GLFWwindow) make_context_current() {
    C.glfwMakeContextCurrent(window)
}

pub fn (window &GLFWwindow) destroy() {
    C.glfwDestroyWindow(window)
}

pub fn (window &GLFWwindow) should_close() bool {
    return C.glfwWindowShouldClose(window)
}

pub fn (window &GLFWwindow) set_pos(x int, y int) {
    C.glfwSetWindowPos(window, x, y)
}

pub fn (window &GLFWwindow) set_framebuffer_size_callback(callback GLFWsizefun) GLFWsizefun {
    return C.glfwSetFramebufferSizeCallback(window, callback)
}

pub fn (window &GLFWwindow) get_framebuffer_size() Size {
    mut width := 0
    mut height := 0
    C.glfwGetFramebufferSize(window, &width, &height)
    return Size{width, height}
}

pub fn (window &GLFWwindow) swap_buffers() {
    C.glfwSwapBuffers(window)
}

pub fn (window &GLFWwindow) set_user_pointer(pointer voidptr) {
    C.glfwSetWindowUserPointer(window, pointer)
}

pub fn (window &GLFWwindow) get_user_pointer() voidptr {
    return C.glfwGetWindowUserPointer(window)
}

pub fn (window &GLFWwindow) set_key_callback(callback GLFWkeyfun) GLFWkeyfun {
    return C.glfwSetKeyCallback(window, callback)
}

pub fn (window &GLFWwindow) set_cursor_pos_callback(callback GLFWcursorposfun) GLFWcursorposfun {
    return C.glfwSetCursorPosCallback(window, callback)
}

pub fn (window &GLFWwindow) set_mouse_button_callback(callback GLFWmousebuttonfun) GLFWmousebuttonfun {
    return C.glfwSetMouseButtonCallback(window, callback)
}

pub fn (window &GLFWwindow) set_window_size_callback(callback GLFWsizefun) GLFWsizefun {
    return C.glfwSetWindowSizeCallback(window, callback)
}

pub fn (window &GLFWwindow) get_window_size() Size {
    mut width := 0
    mut height := 0
    C.glfwGetWindowSize(window, &width, &height)
    return Size{width, height}
}

// glfwSetCharCallback
// glfwSetCharModsCallback
