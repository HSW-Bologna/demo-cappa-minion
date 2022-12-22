
if(NOT "/home/maldus/Projects/HSW/demo-cappa-minion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-gitinfo.txt" IS_NEWER_THAN "/home/maldus/Projects/HSW/demo-cappa-minion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: '/home/maldus/Projects/HSW/demo-cappa-minion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "/home/maldus/Projects/HSW/demo-cappa-minion/components/liblightmodbus-esp/repo"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/home/maldus/Projects/HSW/demo-cappa-minion/components/liblightmodbus-esp/repo'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git"  clone --no-checkout --config "advice.detachedHead=false" "https://github.com/jacajack/liblightmodbus.git" "repo"
    WORKING_DIRECTORY "/home/maldus/Projects/HSW/demo-cappa-minion/components/liblightmodbus-esp"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/jacajack/liblightmodbus.git'")
endif()

execute_process(
  COMMAND "/usr/bin/git"  checkout master --
  WORKING_DIRECTORY "/home/maldus/Projects/HSW/demo-cappa-minion/components/liblightmodbus-esp/repo"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'master'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "/usr/bin/git"  submodule update --recursive --init 
    WORKING_DIRECTORY "/home/maldus/Projects/HSW/demo-cappa-minion/components/liblightmodbus-esp/repo"
    RESULT_VARIABLE error_code
    )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/home/maldus/Projects/HSW/demo-cappa-minion/components/liblightmodbus-esp/repo'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "/home/maldus/Projects/HSW/demo-cappa-minion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-gitinfo.txt"
    "/home/maldus/Projects/HSW/demo-cappa-minion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/home/maldus/Projects/HSW/demo-cappa-minion/build/liblightmodbus-src-subbuild/liblightmodbus-src-populate-prefix/src/liblightmodbus-src-populate-stamp/liblightmodbus-src-populate-gitclone-lastrun.txt'")
endif()

