hs.alert.show("Hammerspoon config loaded")

fennel = require("fennel")
table.insert(package.loaders or package.searchers, fennel.searcher)

require "wm"
