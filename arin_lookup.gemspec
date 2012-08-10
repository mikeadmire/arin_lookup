Gem::Specification.new do |s|
  s.name        = 'arin_lookup'
  s.version     = '0.0.5'
  s.date        = '2012-08-08'
  s.summary     = "Lookup info in ARIN database"
  s.description = "An interface to the American Registry for Internet Numbers (ARIN) API."
  s.authors     = ["Mike Admire"]
  s.email       = 'mike@admire.org'
  s.files       = ["lib/arin_lookup.rb"]
  s.homepage    = 'http://github.com/mikeadmire/arin_lookup'
  s.add_runtime_dependency "json"
end
