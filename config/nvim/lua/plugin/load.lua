local packer

local function init()
    if packer == nil then
        packer = require('packer')
        packer.init({
            disable_commands = true,
            display = {
                open_fn = require('packer.util').float,
            }
        })
    end

    packer.reset()

    for _, name in pairs {
        'all',
    } do packer.use(require('plugin.'..name)) end
end

return setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})
