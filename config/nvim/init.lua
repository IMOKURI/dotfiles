 -- _|_|_|  _|      _|    _|_|    _|    _|  _|    _|  _|_|_|    _|_|_|
 --   _|    _|_|  _|_|  _|    _|  _|  _|    _|    _|  _|    _|    _|
 --   _|    _|  _|  _|  _|    _|  _|_|      _|    _|  _|_|_|      _|
 --   _|    _|      _|  _|    _|  _|  _|    _|    _|  _|    _|    _|
 -- _|_|_|  _|      _|    _|_|    _|    _|    _|_|    _|    _|  _|_|_|

pcall(require, "impatient")

-- Setup global functions
require("global")

-- Setup runtime configurations
require("rc.option")
require("rc.mapping")
require("rc.autocmd")

-- Setup plugins
require("plugin")
pcall(require, "packer_compiled")

require("playground")
