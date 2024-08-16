# deault .zshrc for music cparch install

# load version control info
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{yellow}%༄%f %F{cyan}%n%f %F{yellow}${vcs_info_msg_0_}%f$ '

PROMPT="%F{yellow}𝄞%f %F{cyan}%n%f %F{yellow}𝅘𝅥𝅮%f %F{red}$HOSTNAME%f %F{cyan}⟪%f%F{yellow}%1~%f %F{green}⎣%f%F{yellow}${vcs_info_msg_0_}%f%F{green}⎤%f %F{cyan}⟫%f %F{yellow}🙟%f  "
RPROMPT="%F{red}%t%f"

export CPRDB="teleband"
export CPRDIR="~/MusicCPR/dev"

alias MUSENV="source $(find ~ -name musenv)/bin/activate"

