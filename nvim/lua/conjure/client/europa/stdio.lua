-- [nfnl] Compiled from fnl/conjure/client/europa/stdio.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("conjure.nfnl.module")
local autoload = _local_1_["autoload"]
local a = autoload("conjure.aniseed.core")
local str = autoload("conjure.aniseed.string")
local stdio = autoload("conjure.remote.stdio")
local config = autoload("conjure.config")
local client = autoload("conjure.client")
local log = autoload("conjure.log")
config.merge({client = {europa = {stdio = {command = "europa", prompt_pattern = ">"}}}})
local cfg = config["get-in-fn"]({"client", "europa", "stdio"})
local state
local function _2_()
  return {repl = nil}
end
state = client["new-state"](_2_)
local buf_suffix = ".eu"
local comment_prefix = "; "
print("Stdio")
local function start()
  print("Start")
  print(cfg)
  print(cfg({"prompt_pattern"}))
  print(cfg({"command"}))
  if state("repl") then
    return log.append({(comment_prefix .. "Can't start, REPL is already running."), (comment_prefix .. "Stop the REPL with " .. config["get-in"]({"mapping", "prefix"}) .. cfg({"mapping", "stop"}))}, {["break?"] = true})
  else
    local function _3_()
      return print("Success")
    end
    local function _4_(err)
      return print("Error")
    end
    local function _5_(code, signal)
      return print("Exit")
    end
    local function _6_(output)
      return print("Stray output")
    end
    return a.assoc(state(), "repl", stdio.start({["prompt-pattern"] = cfg({"prompt_pattern"}), cmd = cfg({"command"}), ["on-success"] = _3_, ["on-error"] = _4_, ["on-exit"] = _5_, ["on-stray-output"] = _6_}))
  end
end
local function on_load()
  print("On load")
  return start()
end
local function format_message(msg)
  return str.split((msg.out or msg.err), "\n")
end
local function display_result(msg)
  local function _8_(_241)
    return not ("" == _241)
  end
  return log.append(a.filter(_8_, format_message(msg)))
end
local function eval_str(opts)
  print("Eval str")
  print(opts.code)
  local repl = state("repl")
  local function _9_(msgs)
    print("Fun")
    print(a.count(msgs))
    do
      local foo
      local function _10_(_241)
        return (".." ~= _241.out)
      end
      foo = a.filter(_10_, msgs)
      print("foo")
      print(a.last, foo)
    end
    local msgs0
    local function _11_(_241)
      return (".." ~= _241.out)
    end
    msgs0 = a.filter(_11_, msgs)
    if opts["on-result"] then
      opts["on-result"](str.join("\n", format_message(a.last(msgs0))))
    else
    end
    print("Let")
    print(vim.inspect(msgs0))
    print(a["get-in"](msgs0, {1, "out"}))
    a["run!"](display_result, msgs0)
    return print("done")
  end
  return repl.send((opts.code .. "\n"), _9_, {["batch?"] = true})
end
local function eval_file(opts)
  return eval_str(a.assoc(opts, "code", a.slurp(opts["file-path"])))
end
return {["buf-suffix"] = buf_suffix, ["comment-prefix"] = comment_prefix, ["on-load"] = on_load, start = start, ["eval-str"] = eval_str, ["eval-file"] = eval_file}
