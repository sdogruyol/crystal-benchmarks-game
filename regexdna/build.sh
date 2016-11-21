if [ ! -f 1.txt ]; then
	sh generate.sh
fi

ccrystal build regexdna.cr --release -o bin_cr
