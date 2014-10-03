Gem::Specification.new do |s|
	s.name        = 'maze'
	s.version     = '1.0.0'
	s.date        = '2014-10-01'
	s.licenses    = ["MIT"]
	s.platform    = Gem::Platform::RUBY
	s.summary     = "Library for maze generation"
	s.description = "Library for maze generation"
	s.authors     = ["Pedro Lira"]
	s.email       = 'pedrohml@gmail.com'
	s.files         = `git ls-files`.split("\n")
	s.test_files    = `git ls-files -- spec/*`.split("\n")
	s.homepage    = 'https://github.com/pedrohml/maze'
	s.require_paths = ["lib"]
end
