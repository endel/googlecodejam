spec = Gem::Specification.new do |s|
  s.name = 'googlecodejam'
  s.version = '0.1'
  s.summary = 'Google Code Jam - Runner Utility for Ruby'
  s.description = 'Google Code Jam - Runner Utility for Ruby'
  s.author = ['Endel Dreyer']
  s.email = ['endel.dreyer@gmail.com']
  s.homepage = "https://github.com/endel/googlecodejam"

  s.files = `git ls-files`.split("\n").select {|f| !f.index('.rb.swp') }
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path = "lib"
  s.bindir = "bin"
end
