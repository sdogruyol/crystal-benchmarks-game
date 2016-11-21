if [ ! -f 1.txt ]; then
	sh generate.sh
fi

ccrystal build revcomp.cr --release -o bin_cr
