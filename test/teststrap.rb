require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'riot'
require 'guard'
require File.expand_path('../../lib/guard/tilt', __FILE__)

class Content < Guard::Tilt::Path

  ReturnParameter = Class.new do
    def method_missing(m, *params) return m => params end
  end.new

  def open(mode)
    (@content = yield(ReturnParameter)[:write].first).length
  end
  attr_reader :content

  @instances = {}

  def self.new(path)
    @instances[path] ||= super
  end
  def self.[](path)
    path = File.join Guard::Tilt.root, path
    @instances[path]
  end

end

Guard.guards # initialize guards array
Guard::Dsl.new.instance_eval do
  guard('tilt') { watch %r'views/.+\..+\..+' }
end
Guard::Tilt.path = Content
