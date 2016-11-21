if [ ! -f 1.txt ]; then
	sh generate.sh
fi

ccrystal build knucleotide.cr --release -o bin_cr
