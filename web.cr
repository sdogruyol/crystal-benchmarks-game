require "kemal"

get "/" do
  result_path = Dir.current + "/results/#{Time.now.to_s("%d.%m.%y")}.json"
  results = File.read result_path
  render "views/index.ecr"
end

Kemal.run
