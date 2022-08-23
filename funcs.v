module glfw3

fn C.glfwInit()
fn C.glfwWindowHint(hint int, value int)
fn C.glfwCreateWindow(width int, height int, title charptr, monitor &GLFWmonitor, share &GLFWwindow) &GLFWwindow
fn C.glfwSwapInterval(interval int)
fn C.glfwPollEvents()
fn C.glfwTerminate()
fn C.glfwMakeContextCurrent(window &GLFWwindow)
fn C.glfwDestroyWindow(window &GLFWwindow)
fn C.glfwWindowShouldClose(window &GLFWwindow) bool
fn C.glfwSetWindowPos(window &GLFWwindow, x int, y int)
fn C.glfwGetFramebufferSize(window &GLFWwindow, width &int, height &int)
fn C.glfwSwapBuffers(window &GLFWwindow)
fn C.glfwSetWindowUserPointer(window &GLFWwindow, pointer voidptr)
fn C.glfwGetWindowUserPointer(window &GLFWwindow) voidptr
fn C.glfwSetKeyCallback(window &GLFWwindow, callback GLFWkeyfun) GLFWkeyfun
fn C.glfwSetCursorPosCallback(window &GLFWwindow, callback GLFWcursorposfun) GLFWcursorposfun
fn C.glfwSetMouseButtonCallback(window &GLFWwindow, callback GLFWmousebuttonfun) GLFWmousebuttonfun
fn C.glfwGetCurrentContext() &GLFWwindow
