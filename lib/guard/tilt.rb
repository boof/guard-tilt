require 'guard/guard'
require 'guard/watcher'
require 'tilt'

module Guard
  class Tilt < Guard

    DEFAULT_CONTEXT = Struct.new(:path)
    DEFAULT_LOCALS  = Hash.new({})

    def self.output_path=(klass) @@path = klass; end
    def self.root=(root) @@root = root; end
    def self.root; @@root; end

    def initialize(watchers = [], options = {})
      @context  = options.delete(:context) || DEFAULT_CONTEXT
      @locals   = options.delete(:locals)  || DEFAULT_LOCALS

      super watchers, options
    end
    def start
      log 'Waiting for changes'
    end
    def stop
    end

    def reload
      if @locals.respond_to? :reload
        log 'Reloading locals'
        @locals.reload
      end
    end

    def run_on_change(paths)
      paths.each do |pathname|
        full_pathname = File.expand_path pathname, @@root

        next unless template = template_for(full_pathname)
        next unless content = render_template(template, pathname)

        path = @@path.new full_pathname
        next unless write_content(content, path)

        log "Rendered #{ pathname } to #{ path.to_s @@root }"
      end
    end
    def run_all
      paths = Watcher.match_files self, Dir[ File.join('**', '*') ]
      run_on_change paths
    end

    protected

      def log(message, severity = :info)
        UI.send severity, "#{ self.class }: #{ message }"
      end

      def template_for(path)
        ::Tilt.new File.expand_path(path, @@root)
      rescue RuntimeError => e
        log e.message, :warn
      rescue Exception => e
        log e.message, :error
      end
      def render_template(template, path)
        context = @context.new path
        locals  = @locals.fetch path, {}

        template.render(context, locals)
      rescue Exception => e
        log e.message, :error
      end
      def write_content(content, path)
        path.open('w') { |f| f.write(content) }
      rescue Exception => e
        log e.message, :error
      end

  end
end

require File.expand_path('../tilt/output_path.rb', __FILE__)
Guard::Tilt.root = Dir.getwd
