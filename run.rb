require "fileutils"
require "json"

benchmarks = %w(binarytrees fannkuchredux fasta knucleotide mandelbrot meteor
				nbody pidigits regexdna revcomp spectralnorm threadring)

current_dir = Dir.pwd
tmp_results_path = File.join(current_dir, "results", "results.json")
benchmark_date = Time.now.strftime("%d.%m.%y")
results_path = File.join current_dir, "results", "results_#{benchmark_date}.json"

Dir.mkdir("results") unless Dir.exists?(File.join(current_dir,"results"))
FileUtils.rm results_path if File.exists? results_path
FileUtils.rm tmp_results_path if File.exists? tmp_results_path

benchmarks.each_with_index do |benchmark, index|
  path = File.join Dir.pwd, benchmark
  puts "Running #{benchmark} with #{path}/run.sh"
  `cd #{path} && sh run.sh`
  result_json = IO.readlines(tmp_results_path)[-1]
  result_json = JSON.parse(result_json)
  result_json[:name] = benchmark
  File.open(results_path, "a") { |file| file.puts result_json.to_json}
end

