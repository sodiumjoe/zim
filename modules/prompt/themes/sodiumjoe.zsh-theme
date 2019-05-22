# Authors: Joe Moon <joe@xoxomoon.com>

sodiumjoe_vimode(){
  case $KEYMAP in
    vicmd)
      print '%{%F{white}%}➤%f '
      ;;
    *)
      print '%{%F{blue}%}➤%f '
      ;;
  esac
}

function zle-line-init zle-line-finish zle-keymap-select {
  case $KEYMAP in
    vicmd)      echo -ne "\e[2 q";; # block cursor
    viins|main) echo -ne "\e[6 q";; # line cursor
  esac
  zle reset-prompt
  zle -R
}

prompt_sodiumjoe_precmd() {
  zle -N zle-line-init
  zle -N zle-keymap-select
  zle -N zle-line-finish
  PROMPT='$(sodiumjoe_vimode)'
}

prompt_sodiumjoe_setup() {

  autoload -Uz add-zsh-hook

  add-zsh-hook precmd prompt_sodiumjoe_precmd
  prompt_opts=(cr subst percent)

}

prompt_sodiumjoe_setup '$@'
