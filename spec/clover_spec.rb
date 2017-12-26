require "spec_helper"

RSpec.describe Clover do
  it "has a version number" do
    expect(Clover::VERSION).to_not be nil
  end
end
