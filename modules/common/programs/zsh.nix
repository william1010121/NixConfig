# Zsh configuration with cross-platform support
{ config, pkgs, lib, isDarwin ? true, ... }:

let
  # Platform-specific paths
  homebrewZshAutosuggestions = "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh";

  # macOS-specific environment variables
  darwinEnvVars = ''
    export PATH="/opt/homebrew/opt/libgit2@1.7/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/libgit2@1.7/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/libgit2@1.7/include"

    export LDFLAGS="-L/opt/homebrew/Cellar/taglib/1.13.1/lib"
    export CPPFLAGS="-I/opt/homebrew/Cellar/taglib/1.13.1/include/"

    export TEXMFCNF="/opt/homebrew/opt/texlive/share/texmf-dist/web2c"
    export TEXMFDIST="/opt/homebrew/opt/texlive/share/texmf-dist"
    export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig:$PKG_CONFIG_PATH"
    export LIBGS="/Users/guoshengwei/lib/libgs.dylib"
  '';

  # macOS-specific aliases
  darwinAliases = ''
    alias math="/Applications/Wolfram.app/Contents/MacOS/MathKernel"
    alias wezterm="/Applications/WezTerm.app/Contents/MacOS/wezterm"
    alias gasm="java -jar /Users/guoshengwei/Desktop/NYCU/computer\ architecture/rars/rars.jar"
    alias asm="java -jar /Users/guoshengwei/Desktop/NYCU/computer\ architecture/rars/rars.jar nc p"
  '';

  # Common zsh configuration
  commonConfig = ''
    # Path to Oh My Zsh installation
    export ZSH="$HOME/.oh-my-zsh"

    # Theme
    ZSH_THEME="powerlevel10k/powerlevel10k"

    # Plugins
    plugins=(git z zsh-autosuggestions dirhistory)

    source $ZSH/oh-my-zsh.sh

    # Editor
    export EDITOR='vim'

    # Emacs aliases
    alias em="emacsclient -nw"
    alias ee="emacsclient -n"
    alias ec="emacsclient -cn"
    alias d="emacsclient -q --no-wait"
    alias doom="~/.config/emacs/bin/doom"

    # fzf integration
    source <(fzf --zsh)

    # Cargo
    export PATH="/Users/guoshengwei/.cargo/bin:$PATH"

    # vterm support for Emacs
    vterm_printf() {
        if [ -n "$TMUX" ] && ([ "''${TERM%%-*}" = "tmux" ] || [ "''${TERM%%-*}" = "screen" ]); then
            printf "\ePtmux;\e\e]%s\007\e\\" "$1"
        elif [ "''${TERM%%-*}" = "screen" ]; then
            printf "\eP\e]%s\007\e\\" "$1"
        else
            printf "\e]%s\e\\" "$1"
        fi
    }

    vterm_prompt_end() {
        vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
    }

    if [[ "$INSIDE_EMACS" = 'vterm' ]] \
           && [[ -n ''${EMACS_VTERM_PATH} ]] \
           && [[ -f ''${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh ]]; then
        echo "Inside Emacs vterm"
    fi

    if [[ -n "$INSIDE_EMACS" ]]; then
        echo "Inside Emacs vterm"
        setopt PROMPT_SUBST
        PROMPT="''${PROMPT}%{$(vterm_prompt_end)%}"
    fi

    export DISPLAY=:0

    # Kubernetes aliases
    alias k="kubectl"

    # eza aliases
    alias ls='eza --icons=auto --group-directories-first'
    alias ll='eza -l --header --git --icons=auto --group-directories-first'

    # SSH agent
    eval $(ssh-agent -s)
    ssh-add ~/.ssh/github 2>/dev/null || true

    # Kubernetes config
    export KUBECONFIG=$HOME/.kube/cluster/self-website-k8s.conf:$HOME/.kube/config:$HOME/.kube/cluster/csit-www.conf:$HOME/.kube/cluster/newbie.conf:$HOME/.kube/cluster/csit-system.conf

    # Kubectl completion
    source <(kubectl completion zsh) 2>/dev/null || true

    # RISC-V
    export PATH=/opt/riscv/bin:$PATH

    # Pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - zsh)" 2>/dev/null || true

    # Powerlevel10k
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    # Key bindings
    bindkey "^[B" dirhistory_zle_dirhistory_back
    bindkey "^[b" backward-word
    bindkey "^[F" dirhistory_zle_dirhistory_future
    bindkey "^[f" forward-word

    # Elan (Lean)
    export PATH="$HOME/.elan/bin:$PATH"

    # NPM Global Packages
    export PATH="$HOME/.npm-global/bin:$PATH"

    # fzf options
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
    export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

    # Claude aliases
    alias cc1="CLAUDE_CONFIG_DIR=~/.claude-account1 claude"
    alias cc2="CLAUDE_CONFIG_DIR=~/.claude-account2 claude"
    alias ccusage2="CLAUDE_CONFIG_DIR=~/.claude-account2 ccusage"

    # direnv hook
    eval "$(direnv hook zsh)"
  '';
in
{
  programs.zsh = {
    enable = true;
    initContent = ''
      ${commonConfig}

      ${lib.optionalString isDarwin ''
        # macOS-specific: Source Homebrew zsh-autosuggestions
        [[ -f "${homebrewZshAutosuggestions}" ]] && source "${homebrewZshAutosuggestions}"

        # macOS-specific environment variables
        ${darwinEnvVars}

        # macOS-specific aliases
        ${darwinAliases}
      ''}

      ${lib.optionalString (!isDarwin) ''
        # Linux-specific configuration
        # Source zsh-autosuggestions from nix store if available
        if [[ -f "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
          source "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        fi
      ''}
    '';
  };
}
