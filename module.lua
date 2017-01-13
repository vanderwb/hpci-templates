require("posix")

-- The message printed by the module whatis command
whatis("@NAME v@VERS")

-- The message printed by the module help command
help([[
This is really cool software that does cool things!
PLACEHOLDER DESCRIPTION -- PLEASE CHANGE!

Software website - 

Built on @DATE
Modules used:
]])

-- Set prerequisites and conflicts


-- Set paths for software binaries, libraries, headers, and manuals
local basepath = "@BASE"
local binpath  = pathJoin(basepath,"/bin")                   -- binaries
local libpath  = pathJoin(basepath,"/lib")                   -- libraries
local incpath  = pathJoin(basepath,"/include")               -- include files
local manpath  = pathJoin(basepath,"/share/man")             -- man pages
local libs     = "@LIBS"

-- Update the binary and manual paths in user environment
prepend_path("PATH",binpath)
prepend_path("MANPATH",manpath)

-- Configure NCAR compiler wrappers to use headers and libraries
setenv("NCAR_INC_@WRAP", incpath)
setenv("NCAR_LDFLAGS_@WRAP", libpath)
setenv("NCAR_LIBS_@WRAP", libs)
