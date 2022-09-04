module glfw3

#flag -DGLFW_INCLUDE_NONE

$if windows {
    // These hard coded paths should not be necessary.
    // This initially worked without a full path.
    // ¯\_(ツ)_/¯
    #flag -LC:/msys64/mingw64/bin/
    #flag -lglfw3
    #include "C:/msys64/mingw64/include/GLFW/glfw3.h"
} $else {
    #flag -lglfw
    #include "GLFW/glfw3.h"
}
