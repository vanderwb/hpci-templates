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
prereq("python")

-- Set paths for software binaries, libraries, headers, and manuals
local basepath = "@BASE"
local binpath  = pathJoin(basepath,"/bin")                          -- binaries
local pypath   = pathJoin(basepath,"/lib/python2.7/site-packages/") -- python libs

-- Update the binary and manual paths in user environment
prepend_path("PATH",binpath)
prepend_path("PYTHONPATH",pypath)
