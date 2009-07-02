require File.dirname(__FILE__) + '/integration_spec_helper'

describe "sanitized_html" do
  examples_from_yaml do |doc|
    RedCloth.new(doc['in'], [:sanitize_html]).to_html
  end
end