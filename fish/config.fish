if status is-interactive
    # Commands to run in interactive sessions can go here
  set -gx PATH $PATH ~/.local/bin ~/.okta/bin
end

if status is-login
end

# Key bindings

# binds Ctrl-Meta-M to monitor switch function
#bind \e\[109\;13u mswitch

