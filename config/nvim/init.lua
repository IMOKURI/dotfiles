 -- _|_|_|  _|      _|    _|_|    _|    _|  _|    _|  _|_|_|    _|_|_|
 --   _|    _|_|  _|_|  _|    _|  _|  _|    _|    _|  _|    _|    _|
 --   _|    _|  _|  _|  _|    _|  _|_|      _|    _|  _|_|_|      _|
 --   _|    _|      _|  _|    _|  _|  _|    _|    _|  _|    _|    _|
 -- _|_|_|  _|      _|    _|_|    _|    _|    _|_|    _|    _|  _|_|_|

pcall(require, "impatient")

-- Setup runtime configurations
require("rc.option")
require("rc.mapping")
require("rc.autocmd")

-- Setup plugins
require("plugin")
pcall(require, "packer_compiled")
