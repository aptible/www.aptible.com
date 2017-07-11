require 'spec_helper'

describe ContentfulHelpers do
  describe 'markdown_map' do
    let(:fixtures_root) do
      File.join(File.dirname(__FILE__), '..', 'fixtures/contentful')
    end

    it 'correctly translates Blog resources to Markdown' do
      Dir.glob(File.join(fixtures_root, 'blog', '*')).each do |fixture|
        yaml = File.read(File.join(fixture, 'input.yml'))
        expected_markdown = File.read(File.join(fixture, 'output.md'))
        markdown_map = described_class.markdown_map('blogPost', yaml)

        markdown_path = "source/blog/#{File.basename(fixture)}.md"
        expect(markdown_map[markdown_path]).to eq expected_markdown
      end
    end

    it 'correctly translates Learn resources to Markdown' do
      Dir.glob(File.join(fixtures_root, 'learn', '*')).each do |fixture|
        yaml = File.read(File.join(fixture, 'input.yml'))
        expected_markdown = File.read(File.join(fixture, 'output.md'))
        markdown_map = described_class.markdown_map('resourcePage', yaml)

        markdown_path = "source/learn/#{File.basename(fixture)}.md"
        expect(markdown_map[markdown_path]).to eq expected_markdown
      end
    end

    it 'correctly translates Webinar resources to Markdown' do
      Dir.glob(File.join(fixtures_root, 'webinars', '*')).each do |fixture|
        yaml = File.read(File.join(fixture, 'input.yml'))
        expected_markdown = File.read(File.join(fixture, 'output.md'))
        expected_transcript = File.read(File.join(fixture,
                                                  '_output-transcript.md'))
        markdown_map = described_class.markdown_map('resourcePage', yaml)

        basename = File.basename(fixture)
        markdown_path = "source/resources/#{basename}.md"
        transcript_path = "source/resources/_#{basename}-transcript.md"

        expect(markdown_map[markdown_path]).to eq expected_markdown
        expect(markdown_map[transcript_path]).to eq expected_transcript
      end
    end

    it 'correctly translates other resources to Markdown' do
      Dir.glob(File.join(fixtures_root, 'resources', '*')).each do |fixture|
        yaml = File.read(File.join(fixture, 'input.yml'))
        expected_markdown = File.read(File.join(fixture, 'output.md'))
        markdown_map = described_class.markdown_map('resourcePage', yaml)

        markdown_path = "source/resources/#{File.basename(fixture)}.md"
        expect(markdown_map[markdown_path]).to eq expected_markdown
      end
    end
  end
end
