# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ci_reporter_shell/version'

Gem::Specification.new do |spec|
  spec.name          = 'ci_reporter_shell'
  spec.version       = CiReporterShell::VERSION
  spec.authors       = ['Michal Cichra']
  spec.email         = ['michal@o2h.cz']

  spec.summary       = %q{Write JUnit reports when executing shell scripts}
  spec.description   = %q{If you need to report shell script results to JUnit}
  spec.homepage      = 'https://github.com/3scale/ci_reporter_shell'

  spec.files         = Dir['lib/**/*.rb'] + Dir['exe/**/*'] + %w(README.md Rakefile)
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.license = 'MIT'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_development_dependency 'rspec', '~> 3.4'

  spec.add_runtime_dependency 'ci_reporter', '~> 2.0'
end
