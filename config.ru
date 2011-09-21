run lambda { |env|
  path = env["REQUEST_PATH"][1..-1]
  path = "index.html" if path.empty?
  extension = path.match(/.*\.(.*)/)
  if (File.exists?(path))
    [200, {"Content-Type"=>"text/#{extension}"}, File.new(path)]
  else
    [404, {"Content-Type"=>"text/html"}, String.new("404 Not Found")]
  end
}
