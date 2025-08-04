(local {: autoload} (require :conjure.nfnl.module))
(local a (autoload :conjure.aniseed.core))
(local str (autoload :conjure.aniseed.string))
(local stdio (autoload :conjure.remote.stdio))
(local config (autoload :conjure.config))
;(local mapping (autoload :conjure.mapping))
(local client (autoload :conjure.client))
(local log (autoload :conjure.log))
;(local ts (autoload :conjure.tree-sitter))

; TODO prompt_pattern for julia seems to not show, empty "" is problematic.
(config.merge
  {:client
   {:europa
    {:stdio
     {:command "europa"
      :prompt_pattern ">"}}}}) 

(local cfg (config.get-in-fn [:client :europa :stdio]))
(local state (client.new-state #(do {:repl nil})))
(local buf-suffix ".eu")
(local comment-prefix "; ")

;(fn unbatch [msgs]
;  (->> msgs
;       (a.map #(or (a.get $1 :out) (a.get $1 :err)))
;       (str.join "")))

(print "Stdio")
(fn start []
  (print "Start")
  (print cfg)
  (print (cfg [:prompt_pattern]))
  (print (cfg [:command]))
  (if (state :repl)
    (log.append [(.. comment-prefix "Can't start, REPL is already running.")
                 (.. comment-prefix "Stop the REPL with "
                     (config.get-in [:mapping :prefix])
                     (cfg [:mapping :stop]))]
                {:break? true})
  ;(print (.. "Parse Command" (stdio.parse-cmd (cfg [:prompt_pattern]))))

  (a.assoc
    (state) :repl
    (stdio.start 
    {:prompt-pattern (cfg [:prompt_pattern])
     :cmd (cfg [:command])
     :on-success (fn [] (print "Success"))
     :on-error (fn [err] (print "Error"))
     :on-exit (fn [code signal] (print "Exit"))
     :on-stray-output (fn [output] (print "Stray output"))}))))

(fn on-load []
  (print "On load")
  (start))

(fn format-message [msg]
  (str.split (or msg.out msg.err) "\n"))

(fn display-result [msg]
  (log.append
    (->> (format-message msg)
         (a.filter #(not (= "" $1))))))

(fn eval-str [opts]
  (print "Eval str")
  (print opts.code)
  (let [repl (state :repl)]
    (repl.send (.. opts.code "\n")
      (fn [msgs]
        (print "Fun")
        (print (a.count msgs))
        (let [foo (a.filter #(not= ".." (. $1 :out)) msgs)]
          (print "foo")
          (print a.last foo))
        ;(let [{: ok  : out} msgs]
        (let [msgs (a.filter #(not= ".." (. $1 :out)) msgs)]
          (when opts.on-result
              (opts.on-result (str.join "\n" (format-message (a.last msgs)))))
          (print "Let")
          (print (vim.inspect msgs))
          (print (a.get-in msgs [1 :out]))
          ;(opts.on-result (a.get-in msgs [1 :out]))
          ;(log.append (a.get-in msgs [1 :out]))
          ;(opts.on-result out)
          (a.run! display-result msgs)
          (print "done")))
      {:batch? true})))

(fn eval-file [opts]
  (eval-str (a.assoc opts :code (a.slurp opts.file-path))))

{: buf-suffix
 : comment-prefix
 : on-load
 : start
 : eval-str
 : eval-file}
