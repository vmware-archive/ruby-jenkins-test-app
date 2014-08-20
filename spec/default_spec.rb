require "spec_helper"

describe "Jenkins Ruby Test App" do
  it "uses the Gemfile Ruby version" do
    expect(RUBY_VERSION).to eql("2.1.1")
  end

  it "Nokogiri is available" do
    require "nokogiri"
    require "open-uri"

    expect {
      Nokogiri::HTML(
        open("http://www.pivotal.io/")
      )
    }.to_not raise_exception
  end
end
