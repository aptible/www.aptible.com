require 'spec_helper'
require 'yaml'

describe 'Support Table of Contents', type: :feature do
  file = "#{File.dirname(__FILE__)}/../../data/topics.yml"
  toc = YAML.load_file file

  it_behaves_like 'a table of contents', toc, '/support/topics'
end
