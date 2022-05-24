set -x EDITOR code
set -x VISUAL lvim

set OPENSSL "/usr/local/opt/openssl@1.1/bin"
set CROWDIN "/usr/local/opt/crowdin@2/bin"
set CARGO_HOME "$HOME/.cargo/bin"
set -x VOLTA_HOME "$HOME/.volta"
set -x PATH $PATH "$VOLTA_HOME/bin" $OPENSSL $CROWDIN $CARGO_HOME "$HOME/.local/bin"

# SSH
ssh-add -q $HOME/.ssh/id_rsa
ssh-add -q $HOME/.ssh/id_ed25519_bitbucket_goto
ssh-add -q $HOME/.ssh/id_ed25519_github_goto

# FZF
set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"
set -g FZF_CTRL_T_OPTS "--preview 'bat --style=numbers --color=always --line-range :500 {}'"

# #c792ea commands like echo
set fish_color_command c792ea --italics
# #c792ea keywords like if - this falls back on the command color if unset
set fish_color_keyword c792ea --italics
# #ecc48d quoted text like "abc"
set fish_color_quote ecc48d
# #7fdbca IO redirections like >/dev/null
set fish_color_redirection 7fdbca
# #d6deeb process separators like ';' and '&'
set fish_color_end d6deeb
# #ef5350 syntax errors
set fish_color_error ef5350 --bold
# #d9f5dd ordinary command parameters
set fish_color_param d9f5dd
# #637777 comments like '# important'
set fish_color_comment 637777 --italics
# #FFFFFF selected text in vi visual mode
set fish_color_selection FFFFFF
# #7fdbca parameter expansion operators like '*' and '~'
set fish_color_operator 7fdbca
# #f78c6c character escapes like 'n' and 'x70'
set fish_color_escape f78c6c
# #d6deeb autosuggestions (the proposed rest of a command)
set fish_color_autosuggestion d6deeb

#########
# Aliases
#########

# EXA
set -x EXA_ICON_SPACING 1
alias ls 'exa --icons --classify --group-directories-first --color-scale --oneline'
alias ld 'exa --icons --classify --group-directories-first --color-scale --oneline --only-dirs --all'
alias ll 'exa --icons --classify --group-directories-first --color-scale --header --long --time-style=long-iso --binary --grid --git'
alias la 'exa --icons --classify --group-directories-first --color-scale --header --long --time-style=long-iso --binary --grid --git --all'
alias lC 'exa --icons --classify --group-directories-first --color-scale --header --long --time-style=long-iso --binary --grid --git --all --sort=changed'
alias lM 'exa --icons --classify --group-directories-first --color-scale --header --long --time-style=long-iso --binary --grid --git --all --sort=modified'
alias lS 'exa --icons --classify --group-directories-first --color-scale --header --long --time-style=long-iso --binary --grid --git --all --sort=size'
alias lX 'exa --icons --classify --group-directories-first --color-scale --header --long --time-style=long-iso --binary --grid --git --all --sort=extension'
alias lt 'exa --icons --tree --level=2'

# Yarn
abbr -a y yarn
abbr -a ya yarn add
abbr -a yad yarn add --dev
abbr -a yb yarn build
abbr -a yd yarn dev
abbr -a yln yarn lint
abbr -a yout yarn outdated
abbr -a yrm yarn remove
abbr -a ys yarn serve
abbr -a yst yarn start
abbr -a yt yarn test
abbr -a ytc yarn test --coverage

# npm
abbr -a npmO npm outdated
abbr -a npmst npm start
abbr -a npmt npm test
abbr -a npmR npm run

# bun
abbr -a bur bun run
abbr -a burd bun run dev
abbr -a bst bun run start
abbr -a bb bun run build

# git
function fco -d "Use `fzf` to choose which branch to check out" --argument-names branch
  set -q branch[1]; or set branch ''
  git for-each-ref --format='%(refname:short)' refs/remotes | cut -c 8- | fzf --height 10% --layout=reverse --border --query=$branch --select-1 | xargs git checkout
end

function guncommit -d "Undo last commit"
  git reset --soft HEAD~1
end

function gunadd -d "Unstage files"
  git reset HEAD
end

function gprev -d "Checkout last branch"
  git checkout @{-1}
end

function gdiscard -d "Discard changes in a (list of) file(s) in working tree"
  git checkout -- $argv
end

function gcleanout -d "Clean and discard changes and untracked files in working tree"
  git clean -df && git checkout -- .
end

# git diff before commit
function gg -d "Open broot with git diff"
    br --conf ~/.config/broot/git-diff-conf.toml --git-status
end

zoxide init fish | source
starship init fish | source
mcfly init fish | source
mcfly_key_bindings

# Bun
set -Ux BUN_INSTALL "$HOME/.bun"
set -px --path PATH "$HOME/.bun/bin"
