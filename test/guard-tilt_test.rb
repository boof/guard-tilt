require 'teststrap'

context "guard-tilt" do
  setup do
    false
  end

  asserts "i'm a failure :(" do
    topic
  end
end
