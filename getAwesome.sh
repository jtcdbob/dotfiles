#### Variables

home=~
dotfilePath=$HOME/dotfiles/
# subdirs="zsh bash git tmux vim"

#### Create symlinks

# for dir in `ls $dotfilePath | grep -v "*.sh"`;
ls $dotfilePath | grep -v "\.sh" | while read dir
do
        for file in `ls $dir`;
        do
                target=$dotfilePath/$dir/$file
                dest=$home/.$file
                ln -s $target $dest
                echo "Create symlink for $file"
        done
done
