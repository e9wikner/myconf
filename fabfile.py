import os
from fabric.api import local, env

VIM_PATHOGEN_INSTALL_DIR = "/home/{}/.vim/autoload/pathogen.vim".format(env.user)

def install_pathogen(in_dir):
    print("Installing pathogen for vim plugins, see https://tpo.pe/pathogen.vim")
    local("mkdir -p ~/.vim/autoload ~/.vim/bundle")
    local("curl -LSso " + in_dir)


def deploy():

    if not os.path.isfile(VIM_PATHOGEN_INSTALL_DIR):
        install_pathogen(VIM_PATHOGEN_INSTALL_DIR)

    local("cp .zshrc* /home/{}/.".format(env.user))
    local("cp .vimrc* /home/{}/.".format(env.user))

