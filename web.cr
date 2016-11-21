require "kemal"

class Result
  JSON.mapping(
    {
      name:   {type: String},
      time:   {type: Float64},
      memory: {type: Float64},
    })
end

BENCHMARKS = %w(binarytrees fannkuchredux fasta knucleotide mandelbrot meteor
  nbody pidigits regexdna revcomp spectralnorm threadring)

get "/" do |env|
  render "views/index.ecr", "views/layout.ecr"
end

get "/benchmarks" do |env|
  benchmark_name = env.params.query["benchmark"]?
  result_files = Dir.glob(Dir.current + "/results/results_**.json")
  results = {} of String => Array(Result)
  time_results = {} of String => Array(Float64)
  memory_results = {} of String => Array(Float64)

  result_files.each do |result_file|
    benchmark_date = result_file.split("_")[1].gsub(".json", "")
    results_array = [] of Result
    File.read(result_file).each_line do |line|
      result = Result.from_json(line)
      results_array << result
    end
    results[benchmark_date] = results_array
  end

  dates = results.keys.not_nil!

  BENCHMARKS.each do |benchmark|
    time_results[benchmark] = [] of Float64
    memory_results[benchmark] = [] of Float64
    results.each do |k, v|
      v.each do |result|
        if result.name == benchmark
          time_results[benchmark] << result.time
          memory_results[benchmark] << result.memory
        end
      end
    end
  end

  render "views/benchmarks.ecr", "views/layout.ecr"
end

Kemal.run
