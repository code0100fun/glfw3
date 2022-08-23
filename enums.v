module glfw3

pub enum GLHintValue {
    gl_false = 0
    gl_true = 1
}

pub enum GLFWHints {
    version_major = C.GLFW_CONTEXT_VERSION_MAJOR
    version_minor = C.GLFW_CONTEXT_VERSION_MINOR
    opengl_forward_compat = C.GLFW_OPENGL_FORWARD_COMPAT
    opengl_profile = C.GLFW_OPENGL_PROFILE
}

pub enum GLFWOpenGLProfile {
    any = C.GLFW_OPENGL_ANY_PROFILE
    core = C.GLFW_OPENGL_CORE_PROFILE
    compat = C.GLFW_OPENGL_COMPAT_PROFILE
}

pub enum GLFWKeyAction {
    press = C.GLFW_PRESS
    release = C.GLFW_RELEASE
    repeat = C.GLFW_REPEAT
}
