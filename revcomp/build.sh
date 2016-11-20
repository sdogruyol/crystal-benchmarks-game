if [ ! -f 1.txt ]; then
	sh generate.sh
fi

crystal build revcomp.cr --release -o bin_cr
