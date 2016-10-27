require 'spec_helper'
require 'yaml'

describe 'Getting Started Table of Contents', type: :feature do
  file = "#{File.dirname(__FILE__)}/../../data/quickstart.yml"
  toc = YAML.load_file file

  it_behaves_like 'a table of contents', toc, '/support/quickstart'
end
