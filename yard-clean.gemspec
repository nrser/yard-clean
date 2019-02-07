
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yard/clean/version"

Gem::Specification.new do |spec|
  spec.name          = "yard-clean"
  spec.version       = YARD::Clean::VERSION
  spec.authors       = ["nrser"]
  spec.email         = ["neil@neilsouza.com"]

  spec.summary       = %q{Yeah this just adds a `yard clean` command to remove files.}
  # spec.description   = %q{}

  spec.homepage      = "https://github.com/nrser/yard-clean"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  # TODO  No idea what version of YARD this will work back to...
  spec.add_runtime_dependency "yard"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  # spec.add_development_dependency "rspec", "~> 3.0"
end
