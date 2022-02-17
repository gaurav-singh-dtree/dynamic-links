require_relative "../spec_helper"

describe "Config" do
  let(:config) { DynamicLinks::Configuration.new }

  it "should have some bad words list" do
    expect(config.forbidden_keywords.length).to be > 0
  end
end