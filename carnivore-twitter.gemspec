$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'carnivore-twitter/version'
Gem::Specification.new do |s|
  s.name = 'carnivore-twitter'
  s.version = Carnivore::Twitter::VERSION.version
  s.summary = 'Message processing helper'
  s.author = 'Chris Roberts'
  s.email = 'chrisroberts.code@gmail.com'
  s.homepage = 'https://github.com/heavywater/carnivore-twitter'
  s.description = 'Carnivore Twitter source'
  s.require_path = 'lib'
  s.add_dependency 'carnivore', '>= 0.1.8'
  s.add_dependency 'twitter'
  s.files = Dir['**/*']
end
