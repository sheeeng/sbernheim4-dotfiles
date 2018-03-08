const shell = require("shelljs");
const fs = require('fs');
const chalk = require("chalk");

function installHomebrew() {
	shell.cd("~/");

	let brewInstalled = shell.exec("which -s brew").code;

	if (brewInstalled === 0) {
		console.log(chalk.blue("Installing Homebrew"));
		shell.exec('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
	} else {
		console.log(chalk.blue("Updating Homebrew"));
		shell.exec("brew update");
		shell.exec("brew upgrade");
	}

	console.log(chalk.green("Homebrew installation complete"));
}

function installHomebrewPackages() {
	console.log(chalk.blue("Installing git, nvm, neovim, tmux, zsh, cmake, and ctags with homebrew"));

	shell.cd("~/");

	shell.exec("brew install git");
	shell.exec("brew install nvm");
	shell.exec("brew install neovim");
	shell.exec("brew install tmux");
	shell.exec("brew install zsh");
	shell.exec("brew install cmake");
	shell.exec("brew install ctags");
	shell.exec("brew install fzf");

	console.log(chalk.green("Packages installed"));
}

function downloadDotfiles() {
	console.log(chalk.blue("Cloning dotfiles repo"));

	shell.cd("~/");

	shell.exec("git clone https://github.com/sbernheim4/dotfiles.git");
	console.log(chalk.green("Cloning complete"));
}

function setupVimFiles() {
	console.log(chalk.blue("Setting up vim files"));

	shell.cd("~/");

	// Setup vimrc symlink
	if (fs.existsSync(".vimrc")) {
		shell.rm(".vimrc");
	}
	shell.touch(".vimrc")
	shell.ln("-sf", "~/dotfiles/.vimrc", "~/.vimrc");


	// Create .vim folder
	if (fs.existsSync(".vim/")) {
		shell.rm("-rf", ".vim/");
	}

	shell.mkdir(".vim");
	shell.cd(".vim");

	// Create colors folder
	if (fs.existsSync("colors/")) {
		shell.rm("-rf", "colors/");
	}
	shell.mkdir("colors");

	// Create autoload folder
	if (fs.existsSync("autoload/")) {
		shell.rm("-rf", "autoload/");
	}
	shell.mkdir("autoload");

	// Copy plug.vim into autoload
	shell.cp("~/dotfiles/plug.vim", "autoload");

	// Create symlinks for all the vim colorscheme files
	shell.cd("~/dotfiles/vim_colors/");
	shell.ls().forEach(file => {
		shell.touch(`~/.vim/colors/${file}`);
		shell.cd("~/.vim/colors");
		shell.ln("-sf", `~/dotfiles/vim_colors/${file}`, `./${file}`)
		shell.cd("~/dotfiles/vim_colors");
	});

	console.log(chalk.green("Vim files installed"));
}

function setupTmuxFiles() {
	console.log(chalk.blue("Setting up tmux files"));

	shell.cd("~/");

	// Create fresh .tmux.conf
	if (fs.existsSync(".tmux.conf")) {
		shell.rm(".tmux.conf")
	}

	// Set up symlink
	shell.touch(".tmux.conf");
	shell.ln("-sf", "~/dotfiles/.tmux.conf", ".tmux.conf");
	console.log(chalk.green("Tmux files installed"));
}

function setupZshFiles() {
	console.log(chalk.blue("Setting up ZSH files"));

	shell.cd("~/");

	// Create fresh .zshrc
	if (fs.existsSync(".zshrc")) {
		shell.rm(".zshrc");
	}

	// Set up symlink
	shell.touch(".zshrc");
	shell.ln("-sf", "~/dotfiles/.zshrc", ".zshrc");

	// Install .oh-my-zsh
	shell.exec('sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"');


	// Create needed directories and cd into them
	shell.mkdir("-p", ".oh-my-zsh/custom/themes");
	shell.cd(".oh-my-zsh/custom/themes");

	// Set up symlinks for themes
	shell.ls("~/dotfiles/zsh_themes/").forEach(file => {
		shell.touch(file);
		shell.ln("-sf", `~/dotfiles/zsh_themes/${file}`, `./${file}`);
	});

	console.log(chalk.green("ZSH files installed"));
}

function installVimPlugins() {
	shell.cd("~/")
	console.log(chalk.green("To install vim plugins, run vim and then type :PlugInstall"));
}

function changeDefaultShellToZSH() {
	shell.cd("~/");

	shell.exec("chsh -s $(which zsh)");
}

downloadDotfiles();
installHomebrew();
installHomebrewPackages();
setupZshFiles();
setupTmuxFiles();
setupVimFiles();
changeDefaultShellToZSH();
installVimPlugins();
