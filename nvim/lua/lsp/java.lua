local lsp = require('vim.lsp')
local jdtls = require('jdtls')
M = {}

print("Starting JDT")
function M.start_jdt()
--  print('jdt started')
--  local config = {
--    cmd = {
--      '/usr/bin/java',
--	    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--	    '-Dosgi.bundles.defaultStartLevel=4',
--	    '-Declipse.product=org.eclipse.jdt.ls.core.product',
--	    '-Dlog.level=ALL',
--	    '-Xmx1G',
--      --'-jar /home/geoff/Applications/jdtls/plugins/org.eclipse.equinox.launcher_*.jar',
--      '-jar', '/home/geoff/Applications/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210908-1257.jar',
--	    '-configuration', '/home/geoff/Applications/jdtls/config_linux',
--	    '-data', '/home/geoff/.local/share/eclipse',
--	    '--add-modules=ALL-SYSTEM',
--	    '--add-opens java.base/java.util=ALL-UNNAMED',
--	    '--add-opens java.base/java.lang=ALL-UNNAMED'
--    }
--  }
--  jdtls.start_or_attach(config)
end

return M
