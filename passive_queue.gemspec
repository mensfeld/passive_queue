require_relative "lib/passive_queue/version"

Gem::Specification.new do |spec|
  spec.name = "passive_queue"
  spec.version = PassiveQueue::VERSION
  spec.authors = ["Maciej Mensfeld"]
  spec.email = ["void@passivequeue.pro"]

  spec.summary = "A Rails queue adapter that embraces the zen of non-productivity"
  spec.description = "Rails queue adapter for mindful developers. Accepts all jobs, executes none. Perfect reliability through strategic non-action."
  spec.homepage = "https://passivequeue.pro"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mensfeld/passive_queue"
  spec.metadata["changelog_uri"] = "https://github.com/mensfeld/passive_queue/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.executables = ['be']
  spec.require_paths = ["lib"]
  # NO runtime dependencies - true zen has no dependencies
end
