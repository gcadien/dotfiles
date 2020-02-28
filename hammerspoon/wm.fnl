(local spaces (require "hs._asm.undocumented.spaces"))
(global alert hs.alert.show)
(global log (hs.logger.new "wm" "debug"))
(log.i "test")
(alert "Starting Window Manager.")

(fn create-container [layout-type parent size]
 (let [container {:layout-type layout-type :parent parent :size size :children []}]
  container)) 

(alert (. (create-container) :type))

(fn space-id [space]
  (let [win (hs.window.focusedWindow)]
    (let [uuid (: (: win :screen) :spacesUUID)]
      (. (. (spaces.layout) uuid) space))))

(global workspace (create-container :horizontal nil (: (hs.screen.primaryScreen) :frame)))
(global focused-container workspace)

(fn move-window-to-space [space]
    (log.i (space-id 4))
    (spaces.changeToSpace (space-id space)))

(log.i (hs.geometry.rect 10 20 30 40))
(fn layout-container [container]
  (log.i "Doing layout")
  (log.i (# "abc"))
  (let [ {:layout-type layout :parent parent :size size :children children} container]
   (log.i size.w)
   (if (= layout :horizontal) 
     (do (let [win-size (hs.geometry.size (/ size.w (# children)) size.h)]
           (log.i win-size)
           (log.i (# children))

           (each [index child (ipairs children)]
              (let [win (hs.window.focusedWindow) parent (. container :parent)]
              (log.i (: win :frame)))))))))
  
   ;(if (= (. container :layout-type) :horizontal)
   ;  ((log.i "HSplit Container")))))

     ;(let [win (hs.window.focusedWindow) parent (. container :parent)]
     ;  (log.i "Handling Leaf")
     ;  (log.i win)
     ;  (log.i parent))
      ;(each [index child (ipairs children)]
      ;  (log.i (. child :layout-type))
      ;  (layout-container child)))))




(fn app-watcher [name event-type app-object]
  (when (= event-type hs.application.watcher.launched) 
    (alert name)
    (alert (: (hs.screen.primaryScreen) :frame))
    (let [win (hs.window.focusedWindow)]
      (log.i (: win :frame))
      (let [child (create-container :leaf focused-container (: win :frame))]
        (log.i "Creating Child Container")
        (log.i child)
        (log.i focused-container)
        (log.i (. child :parent))
        (table.insert (. focused-container :children) child)
        (log.i (. (. focused-container :children) 1))
        (layout-container focused-container)))))


(hs.hotkey.bind {"cmd", "alt"} "i" (fn [] (log.i "Full Screen")))
;hs.hotkey.bind({"cmd", "alt"}, "i", function()
;  if hs.window.focusedWindow() then
;    local log = hs.logger.new('mymodule','debug')
;    log.i(hs.screen.primaryScreen():frame())
;    log.i(hs.screen.allScreens()[3])
;    local win = hs.window.focusedWindow()
;    local f = win:frame()
;    local screen = win:screen()
;    local max = screen:frame()
;    f.x = max.x
;    f.y = max.y
;    f.w = max.w
;    f.h = max.h
;
;    log:i(max.x)
;    win:setFrame(f)
;    else
;      hs.alert.show("No active window")
;    end
;end)

(: (hs.application.watcher.new app-watcher)  :start)
  


(alert workspace)
(move-window-to-space 4)
;(layout-container workspace)
