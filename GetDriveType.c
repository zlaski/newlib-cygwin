// use quick-cl-build or quick-cl-debug

#include <windows.h>

int main(int argc, char *argv[]) {
    UINT drive_type = GetDriveTypeA(argv[1]);
    return drive_type;
}
