module glfw3

pub type GLFWHintValue = GLFWOpenGLProfile | GLHintValue | int
pub type GLFWkeyfun = fn (window &GLFWwindow, key int, scancode int, action int, mods int)

pub type GLFWcursorposfun = fn (window &GLFWwindow, xpos f64, ypos f64)

pub type GLFWmousebuttonfun = fn (window &GLFWwindow, button int, action int, mods int)
