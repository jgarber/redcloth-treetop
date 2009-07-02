require File.dirname(__FILE__) + '/integration_spec_helper'

describe "filtered_html" do
  examples_from_yaml do |doc|
    RedCloth.new(doc['in'], [:filter_html]).to_html
  end
end