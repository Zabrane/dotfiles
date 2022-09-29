set -gx EDITOR code
set -gx VISUAL nvim

set OPENSSL "/usr/local/opt/openssl@1.1/bin"
set CROWDIN "/usr/local/opt/crowdin@2/bin"
set CARGO_HOME "$HOME/.cargo/bin"
set -x VOLTA_HOME "$HOME/.volta"
set -x ANDROID_HOME "$HOME/Library/Android/sdk"
set ANDROID_SDK_ROOT "$HOME/Library/Android/sdk"
set -x PATH $PATH "$VOLTA_HOME/bin" $OPENSSL $CROWDIN $CARGO_HOME "$ANDROID_SDK_ROOT/emulator" "$ANDROID_SDK_ROOT/platform-tools" "$HOME/.local/bin"

# Bun
set -Ux BUN_INSTALL "$HOME/.bun"
set -px --path PATH "$HOME/.bun/bin"

# SSH
ssh-add -q $HOME/.ssh/id_rsa
ssh-add -q $HOME/.ssh/id_ed25519_bitbucket_goto
ssh-add -q $HOME/.ssh/id_ed25519_github_goto

# FZF
set -g FZF_DEFAULT_OPTS "\
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
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

# neovim
alias nv nvim

# Kitty
abbr -a icat kitty +kitten icat

# LSD
alias ls 'lsd --classify'
alias ll 'lsd --classify --header --long'
alias la 'lsd --classify --header --long --almost-all'
alias lC 'lsd --classify --header --long --almost-all --sort time --group-dirs none'
alias lS 'lsd --classify --header --long --almost-all --sort size --group-dirs none'
alias lt 'lsd --tree --depth=2'

# gfold git tool
alias gfld '~/.cargo/bin/gfold'

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
abbr -a b bun run
abbr -a bd bun run dev
abbr -a bst bun run start
abbr -a bb bun run build
abbr -a bln bun run lint
abbr -a bt bun run test
abbr -a bf bun run format

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

zoxide init fish | source
starship init fish | source
