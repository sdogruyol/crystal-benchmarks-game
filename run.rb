benchmarks = %w(binarytrees fannkuchredux fasta knucleotide mandelbrot meteor
				nbody pidigits regexdna revcomp spectralnorm threadring)

dir = Dir.pwd
benchmarks.each_with_index do |benchmark, index|
  path = File.join Dir.pwd, benchmark
  puts "Running #{benchmark} with #{path}/run.sh"
  `cd #{path} && sh run.sh`
end