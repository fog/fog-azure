# Copyright (c) Microsoft Open Technologies, Inc.  All rights reserved.
#
# The MIT License (MIT)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fog/azure/version'

Gem::Specification.new do |spec|
  spec.name          = "fog-azure"
  spec.version       = Fog::AZURE::VERSION
  spec.authors       = ["Jeff Mendoza", "Ranjan Kumar"]
  spec.email         = ["jemendoz@microsoft.com", "ranjankumar188@gmail.com"]
  spec.summary       = %q{Module for the 'fog' gem to support Azure cloud services.}
  spec.description   = %q{This library can be used as a module for `fog` or as standalone provider
                        to use the Azure cloud services in applications..}
  spec.homepage      = "http://github.com/fog/fog-azure"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  #spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'shindo',  '~> 0.3'
  spec.add_development_dependency('azure', '~>0.6')

  spec.add_dependency 'fog-core',  '~> 1.27'
  spec.add_dependency 'fog-json',  '~> 1.0'
  spec.add_dependency 'fog-xml',   '~> 0.1'
end