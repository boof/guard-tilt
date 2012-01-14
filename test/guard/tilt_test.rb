require File.expand_path('../../teststrap', __FILE__)
Guard::Tilt.root = File.expand_path '..', __FILE__

context "guard-tilt" do

  asserts "rendered content" do
    Guard.guards('tilt').run_all
    Content['views/index.html.erb'].content
  end.equals "2"

end
