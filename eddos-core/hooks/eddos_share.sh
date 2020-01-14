EDDOS_ASK_PERMISSION=${EDDOS_ASK_PERMISSION:-false}

function get_permission {
	msg="$1"
	if "$EDDOS_ASK_PERMISSION"; then
		read -p "$msg  Continue? [y/n]" yn
		case $yn in
			[Yy]* ) return 0;;
			[Nn]* ) return 1;;
		esac
	else
		echo "$msg"
		return 0
	fi
}

# Transparent install function.  Lets the user know what's going on
function transparent_install {
	package="$1"

        # Test if DNF installed
        dnf > /dev/null
        if [ $? -ne 0 ]; then
                echo "DNF not installed.  Are you on Fedora?"
                return 1
        fi

	if dnf list --installed | grep -q "$1"; then
		echo "$package already installed"
		return 0
	fi

        # Installs the package
	if get_permission "Installing package(s) $package."; then
		sudo dnf -y install $package
	fi

        if [ $? -ne 0 ]; then
                echo "Installation failed."
                return 1
        fi
	return 0
}


# Transparent remove function.  Lets the user know what's going on
function transparent_remove {
	package="$1"

        # Test if DNF installed
        dnf > /dev/null
        if [ $? -ne 0 ]; then
                echo "DNF not installed.  Are you on Fedora?"
                return 1
        fi

        # Installs the package
	if get_permission "Removing package(s) $package."; then
		sudo dnf -y remove $1
	fi

        if [ $? -ne 0 ]; then
                echo "Removal failed."
                return 1
        fi
}


# Transparent COPR enable function.  Lets the user know what's going on
function transparent_copr_enable {
	repo="$1"

        # Test if DNF installed
        dnf > /dev/null
        if [ $? -ne 0 ]; then
                echo "DNF not installed.  Are you on Fedora?"
                return 1
        fi

        # Enable the COPR repo
	if get_permission "Enabling COPR repo(s) $repo."; then
		sudo dnf -y copr enable $1
	fi
	
        if [ $? -ne 0 ]; then
                echo "COPR enable failed."
                return 1
        fi
}

# Transparent COPR disable function.  Lets the user know what's going on
function transparent_copr_disable {
        # Test if DNF installed
        dnf > /dev/null
        if [ $? -ne 0 ]; then
                echo "DNF not installed.  Are you on Fedora?"
                return 1
        fi

        # Disable the COPR repo
	if get_permission "Disabling COPR repo(s) $repo."; then
		sudo dnf -y copr disable $1
	fi

        if [ $? -ne 0 ]; then
                echo "COPR disable failed."
                return 1
        fi
}

function transparent_make_root_executable {
	file="$1"
	contents="$2"

#	if [ -e "$1" ]; then
#		echo "$1 already exists.  No changes made."
#		return 0
#	fi

	if get_permission "Creating executable file $1 as root."; then
		sudo sh -c "echo -e \"$contents\" > \"$file\""
		sudo chmod 755 "$file"
	fi
}

function transparent_remove_root_file {
	file="$1"

	if [ ! -e "$1" ]; then
		echo "$1 does not exist.  No changes made."
		return 0
	fi

	if get_permission "Removing file $1 as root."; then
		sudo rm "$1"
	fi
}

function transparent_curl {
	file="$1"
	url="$2"

	if [ -e "$1" ]; then
		echo "$1 exists.  No changes made."
		return 0
	fi

	if get_permission "Downloading $2 to $1."; then
		curl -fLo "$1" --create-dirs "$2"
	fi
}
