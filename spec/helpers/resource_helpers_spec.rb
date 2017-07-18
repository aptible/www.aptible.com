require 'spec_helper'

describe 'pagination helpers' do
  include ResourceHelpers

  describe '#document_file_extension' do
    it 'returns the file extension from a path' do
      path = '/assets/pdf/foo.pdf'
      expect(document_file_extension(path)).to eq 'pdf'

      path = '/assets/pdf/bar.xsl'
      expect(document_file_extension(path)).to eq 'xsl'
    end
  end
end
