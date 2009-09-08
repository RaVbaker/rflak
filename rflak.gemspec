require 'rubygems'

Gem::Specification.new do |spec|
  spec.name = 'rflak'
  spec.version = '0.2'
  spec.author = 'Sebastian Nowak'
  spec.email = 'sebastian.nowak@gmail.com'
  spec.platform = Gem::Platform::RUBY
  spec.summary = 'Simple wraper for http://flaker.pl API'
  spec.files = Dir.glob("{lib,test}/**/*")
  spec.require_path = 'lib'
  spec.extra_rdoc_files = ["README"]
  spec.add_dependency('httparty')
  spec.description = <<-E
Simple Ruby wrapper for Flaker service. Flaker is service collecting your network activities.
For more details go to http://flaker.pl
  E
  spec.homepage = "http://github.com/seban/rflak/tree/master"

end
