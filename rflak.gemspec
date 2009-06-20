require 'rubygems'

Gem::Specification.new do |spec|
  spec.name = 'rflak'
  spec.version = '0.1'
  spec.author = 'Sebastian Nowak'
  spec.email = 'sebastian.nowak@gmail.com'
  spec.platform = Gem::Platform::RUBY
  spec.summary = 'Simple wraper for http://flaker.pl API'
  spec.files = Dir.glob("{lib,test}/**/*")
  spec.require_path = 'lib'
  spec.extra_rdoc_files = ["README"]
  spec.add_dependency('httparty')
end