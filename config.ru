run lambda { |env|
  path = env["REQUEST_PATH"][1..-1]
  path = "index.html" if path.empty?
  extension = path.match(/.*\.(.*)/)[1]

  if extension == "pdf"
    mime-type = "application/pdf"
  else
    mime-type = "text/#{extension}"
  end

  if (File.exists?(path))
    [200, {"Content-Type"=>mime-type}, File.new(path)]
  else
    [404, {"Content-Type"=>"text/html"}, String.new("404 Not Found")]
  end
}
