# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


ZSH_DISABLE_COMPFIX=true
export ZSH="/Users/mikhail/.oh-my-zsh"
plugins=(
  rails
  git
  ruby
  zsh-autosuggestions
  zsh-syntax-highlighting
  dirhistory
  jsontools
)
source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme


export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"
# RUBY_CONFIGURE_OPTS=--with-openssl-dir=/opt/homebrew/opt/openssl@1.1
RUBY_CFLAGS=-DUSE_FFI_CLOSURE_ALLOC
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"


# ARCH ENV
if [ "$(uname -p)" = "i386" ]; then
  # rosetta terminal setup
  . /usr/local/homebrew/opt/asdf/libexec/asdf.sh
  eval "$(/usr/local/homebrew/bin/brew shellenv)"
  alias brew='/usr/local/homebrew/bin/brew'
  alias pyenv86="arch -x86_64 pyenv"
else
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
  eval "$(/opt/homebrew/bin/brew shellenv)"
  alias brew='/opt/homebrew/bin/brew'
fi


# fuck
eval $(thefuck --alias)
eval $(thefuck --alias FUCK)


# pyenv
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# z
source /opt/homebrew/etc/profile.d/z.sh


# Custom scripts/aliases
alias minetest='/opt/homebrew/opt/minetest/minetest.app/Contents/MacOS/minetest'
suspend() {
  ruby -e "
    def humanize(secs)
      [[60, :seconds], [60, :minutes], [24, :hours], [Float::INFINITY, :days]].map{ |count, name|
        if secs > 0
          secs, n = secs.divmod(count)
          \"#{n.to_i} #{name}\" unless n.to_i==0
        end
      }.compact.reverse.join(' ')
    end

    sec = (60*$1)
    sec.times.each do |i|
      print(\"\r#{humanize(sec - i)}\")
      sleep(1)
    end
  ";
  pmset sleepnow;
}


# # profitero work aliases
# alias cdp='/Users/mikhail/projects/profitero/project/'
# alias cds='/Users/mikhail/projects/profitero/scripting/'
# alias cda='/Users/mikhail/projects/profitero/admin_toolkit/'
# alias work_api='cdp; bundle exec ruby -I. -S  thin -R src/config.ru -p 8080 start;'
# alias work_gui='cdp; bundle exec bin/ruby src/gui_server.rb;'
# alias be='bundle exec'
# alias bi='bundle install'
