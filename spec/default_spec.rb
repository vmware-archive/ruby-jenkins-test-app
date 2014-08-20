require "spec_helper"

require "nokogiri"
require "open-uri"
require "ostruct"
require "json"

def cf_dummy_broker
  JSON.parse(
    ENV.fetch("VCAP_SERVICES", "{}")
  ).fetch("cf-dummy-broker", []).first
end

describe "Jenkins Ruby Test App" do
  it "uses the Gemfile Ruby version" do
    expect(RUBY_VERSION).to eql("2.1.1")
  end

  it "Nokogiri is available" do

    expect {
      Nokogiri::HTML(
        open("http://www.pivotal.io/")
      )
    }.to_not raise_exception
  end

  if cf_dummy_broker
    context "when cf-dummy-broker is available in VCAP_SERVICES env" do
      let(:credentials) { OpenStruct.new(cf_dummy_broker.fetch("credentials")) }

      it "can connect to this CF service instance" do
        response = open(
          "#{credentials.uri}/check_credentials",
          http_basic_authentication: [credentials.username, credentials.password]
        )
        expect(response.status).to eql(["200", "OK"])
      end
    end
  end
end

