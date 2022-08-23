module glfw3

pub struct Size {
pub mut:
    width  int
    height int
}

pub struct CreateWindowOptions {
    width   int
    height  int
    title   string
    monitor &GLFWmonitor
    share   &GLFWwindow
}

struct C.GLFWwindow {
}

pub type GLFWwindow = C.GLFWwindow

struct C.GLFWmonitor {
}

pub type GLFWmonitor = C.GLFWmonitor
