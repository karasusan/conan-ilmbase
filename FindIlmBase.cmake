set(ILMBASE_INCLUDE_DIRS "${CONAN_INCLUDE_DIRS_ILMBASE}")
set(ILMBASE_LIBRARY_DIRS "${CONAN_LIB_DIRS_ILMBASE}")

set(ILMBASE_INCLUDE_DIR  "${ILMBASE_INCLUDE_DIRS}")
set(ILMBASE_LIBRARY_DIR  "${ILMBASE_LIBRARY_DIRS}")

set(ILMBASE_LIBRARIES "")

# static library extension 
# lib = Microsoft Visual Studio
# a = Unix (also MacOS)
set(LIB_EXTENSION "a")
if (MSVC)
    set(LIB_EXTENSION "lib")
endif (MSVC)

foreach (LIBNAME ${CONAN_LIBS_ILMBASE})
    string(REGEX MATCH "[^-]+" LIBNAME_STEM ${LIBNAME})

    set(ILMBASE_${LIBNAME_STEM}_LIBRARY "${ILMBASE_LIBRARY_DIRS}/lib${LIBNAME}.${LIB_EXTENSION}")
    list(APPEND ILMBASE_LIBRARIES ILMBASE_${LIBNAME_STEM}_LIBRARY)
endforeach()

set(ILMBASE_LIBRARY "${ILMBASE_LIBRARIES}")

foreach (INCLUDE_DIR ${ILMBASE_INCLUDE_DIRS})
    if(NOT ILMBASE_VERSION AND INCLUDE_DIR AND EXISTS "${INCLUDE_DIR}/OpenEXR/IlmBaseConfig.h")
      file(STRINGS
           ${INCLUDE_DIR}/OpenEXR/IlmBaseConfig.h
           TMP
           REGEX "#define ILMBASE_VERSION_STRING.*$")
      string(REGEX MATCHALL "[0-9.]+" ILMBASE_VERSION ${TMP})
    endif()
endforeach()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args( IlmBase
    REQUIRED_VARS
        ILMBASE_INCLUDE_DIRS
        ILMBASE_LIBRARIES
    VERSION_VAR
        ILMBASE_VERSION
)
