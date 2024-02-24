if status is-interactive
    # Commands to run in interactive sessions can go here
  set -gx PATH $PATH ~/.local/bin ~/.okta/bin
end

if status is-login
end

# Key bindings

# binds Ctrl-Meta-M to monitor switch function
#bind \e\[109\;13u mswitch


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/usr/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/home/geoff/micromamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
