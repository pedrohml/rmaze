expand_path = File.expand_path('..', __FILE__)

$LOAD_PATH.unshift expand_path

Dir.glob(File.join(expand_path, "**/*.rb")) do |file|
    require file
end
