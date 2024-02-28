#include <iostream>
#include <lean/lean.h>

extern "C" double min_number(size_t, size_t, size_t);

extern "C" void lean_initialize_runtime_module();
extern "C" void lean_initialize();
extern "C" void lean_io_mark_end_initialization();
extern "C" lean_object* initialize_ReverseFFIWithMathlib(uint8_t builtin, lean_object* w);

int main(){

    lean_initialize_runtime_module();
    lean_object * res;
    uint8_t builtin = 1;
    res = initialize_ReverseFFIWithMathlib(builtin, lean_io_mk_world());
    if (lean_io_result_is_ok(res)) {
        lean_dec_ref(res);
    } else {
        lean_io_result_show_error(res);
        lean_dec(res);
        return 1;  // do not access Lean declarations if initialization failed
    }
    lean_io_mark_end_initialization();

    
    std::cout << "minimal number of 42 7 69 is: " << min_number(42, 7, 69) << std::endl;

    return 0;
}
