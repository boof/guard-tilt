require File.expand_path('../../../teststrap', __FILE__)

context "guard-tilt" do
  context "output path" do

    setup do
      Guard::Tilt::OutputPath.new '/foo/bar/index.html.erb'
    end

    asserts "strip_extname" do
      topic.strip_extname.to_str
    end.equals '/foo/bar/index.html'

    asserts "sanitize just uses strip_extname by default" do
      topic.sanitize.to_str == topic.strip_extname.to_str
    end
    asserts "to_s uses sanitize" do
      topic.to_s == topic.sanitize.to_str
    end

    asserts "to_s relative to '/foo'" do
      topic.to_s '/foo'
    end.equals 'bar/index.html'

  end
end
