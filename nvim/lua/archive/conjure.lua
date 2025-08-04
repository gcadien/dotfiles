return {
  "Olical/conjure",
  init = function ()
    vim.g["conjure#filetypes"] ={ "clojure", "fennel",  "europa" }
    vim.g["conjure#debug"] = false
    vim.g["conjure#filetype#europa"] = "conjure.client.europa.stdio"
  end
}
