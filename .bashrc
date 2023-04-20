# Get computer
_is_my_desktop=$(hostname | grep nyc-desk-l304)
_is_Hai_desktop=$(hostname | grep nyc-desk-l118)
_is_mac=$(uname -s | grep Darwin)

# Laptop specific
if [[ -n "$_is_mac" ]]; then
    alias vi='/usr/bin/vim'
    alias ssh-nyc-desk-l304='ssh braun1@nyc-desk-l304.schrodinger.com'
    alias ssh-nyc-desk-l118='ssh braun1@nyc-desk-l118.schrodinger.com'
fi
# Desktop specific
if [[ -n "$_is_my_desktop" ]] || [[ -n "$_is_Hai_desktop" ]]; then
    alias tmux='/nfs/utils/bin/tmux'
    shopt -s direxpand # per https://askubuntu.com/a/136633
fi

alias ssh-pdx-git='ssh pdx-git.schrodinger.com'
alias ssh-bolt='ssh braun1@boltsub1.schrodinger.com'

# Terminal colors
export CLICOLOR=1
export TERM=xterm-color
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# Command prompt
PS1="\[\033[0;32m\]\h:\W$ \[\033[0m\]"

# Easily switch between builds:
function select-build() {
    [[ -n "$1" ]] || echo "select-build needs an argument (e.g. select-build 2021-3)"

    if [[ -n "$_is_mac" ]]; then
        export SCHRODINGER_SRC=/Users/$USER/builds/$1/source
        export SCHRODINGER=/Users/$USER/builds/$1/build
        export SCHRODINGER_LIB=/Users/$USER/builds/software/lib
    elif [[ -n "$_is_Hai_desktop" ]]; then
        export SCHRODINGER_SRC=/scr2/$USER/builds/$1/source
        export SCHRODINGER=/scr2/$USER/builds/$1/build
        export SCHRODINGER_LIB=/software/lib
    else
        export SCHRODINGER_SRC=/scr/$USER/builds/$1/source
        export SCHRODINGER=/scr/$USER/builds/$1/build/donotbackup
        export SCHRODINGER_LIB=/scr/$USER/builds/software/lib/donotbackup
    fi
}
# default to latest build
select-build latest

alias buildinger='${SCHRODINGER_SRC}/mmshare/build_tools/buildinger.sh --verbose'
alias buildingeri='buildinger --ignore-branch-mismatch'
alias source-build-env='source ${SCHRODINGER_SRC}/mmshare/build_env'

# partial python builds
function partial-python-build-mmshare() {
    make -C ${SCHRODINGER}/mmshare-v*/python/scripts install
    make -C ${SCHRODINGER}/mmshare-v*/python/modules schrodinger_modules
    make -C ${SCHRODINGER}/mmshare-v*/python/common install
}
function partial-python-build-desmond-gpu-src() {
    make -C $SCHRODINGER/desmond-v* install_schrodinger_modules
}
function partial-python-build-scisol-src() {
    make -C $SCHRODINGER/scisol-v* install
}

# tests
function test-mmshare() {
    make -C ${SCHRODINGER}/mmshare-v*/python/test unittest TEST_ARGS="-v --post_test $*"
}
function test-desmond-gpu-src() {
    make -C ${SCHRODINGER}/desmond-v* py_test TEST_ARGS="-v --post_test $*"
}
function test-scisol-src() {
    make -C ${SCHRODINGER}/scisol-v* test TEST_ARGS="-v --post_test $*"
}
function test-mmshare-pdb() {
    make -C ${SCHRODINGER}/mmshare-v*/python/test unittest TEST_ARGS="-v --post_test --capture=no $*"
}
function test-desmond-gpu-src-pdb() {
    make -C ${SCHRODINGER}/desmond-v* py_test TEST_ARGS="-v --post_test --capture=no $*"
}
function test-scisol-src-pdb() {
    make -C ${SCHRODINGER}/scisol-v* test TEST_ARGS="-v --post_test --capture=no $*"
}

# determine mmshare version
function mmshare_fix_build() {
    bld=${1:-master}
    curl "https://cgit.schrodinger.com/cgit/mmshare/plain/version.h?h=$bld" | grep "#define MMSHARE_VERSION" | awk '{ printf("%03d\n", $3%1000+1) }'
}

# scp functions
scp-from-nyc-desk () {
    scp -r braun1@nyc-desk-l304.schrodinger.com:"$1" "$2"
}
scp-to-nyc-desk () {
    scp -r "$1" braun1@nyc-desk-l304.schrodinger.com:"$2"
}
