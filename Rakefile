require 'rspec/core/rake_task'
require 'yaml'

def system!(cmd)
  success = !!system(cmd)
  exitstatus = $CHILD_STATUS.exitstatus
  raise "Command failed (exit #{exitstatus}): #{cmd}" unless success
end

desc 'Tag current HEAD and push to release branch'
task :deploy, [:bucket] => :redirect do |_t, args|
  raise 'No bucket specified' unless args[:bucket]

  # Update Contentful data
  system!('bundle exec middleman contentful')

  # Build site
  system!('bundle exec middleman build')

  # Upload to S3
  opts = '--acl public-read ' \
         '--cache-control max-age=300,s-maxage=300'

  # http://makandracards.com/makandra/15649
  Bundler.with_clean_env do
    system!("aws s3 sync #{opts} build s3://#{args[:bucket]}")
  end
end

task :redirect, [:bucket] do |_t, args|
  raise 'No bucket specified' unless args[:bucket]

  Bundler.with_clean_env do
    ENV['S3_BUCKET'] = args[:bucket]
    system!('bundle exec middleman s3_redirect')
  end
end

namespace :deploy do
  desc 'Build and deploy site to www.aptible-staging.com'
  task :staging do
    ENV['BASE_URL'] = 'https://www.aptible-staging.com'
    ENV['SEGMENTIO_WRITEKEY'] = 'K24Jna8XS0PRiQiISYZ563qC3SfHF241'
    ENV['SWIFTYPE_KEY'] = '6oJmuDaosp-WnxZNZcxQ'
    ENV['SWIFTYPE_ENGINE'] = 'omxnF9kXa-PmS4uNyRSC'
    # rubocop:disable LineLength
    ENV['CONTENTFUL_KEY'] = 'b66d39f51cfcc747ca3af1b7731bd00cf877b659d69514845ba837ddae473605'
    # rubocop:enable LineLength
    ENV['CONTENTFUL_ENV'] = 'staging'
    Rake::Task[:deploy].invoke('www.aptible-staging.com')
  end

  desc 'Build and deploy site to www.aptible.com'
  task :production do
    ENV['BASE_URL'] = 'https://www.aptible.com'
    ENV['SEGMENTIO_WRITEKEY'] = 'rkt88i7k3w'
    ENV['SWIFTYPE_KEY'] = 'dsMEc1fYviE2ShXAjYMW'
    ENV['SWIFTYPE_ENGINE'] = 'axuhZ5Lt1ZUziN-DqxnR'
    # rubocop:disable LineLength
    ENV['CONTENTFUL_KEY'] = '9f900421de36456577e619e3fbf7f0870954b64ad8f0ead9f3d80f55ceaf4bee'
    # rubocop:enable LineLength
    ENV['CONTENTFUL_ENV'] = 'production'
    Rake::Task[:deploy].invoke('www.aptible.com')
  end
end

namespace :contentful do
  desc 'Convert contentful yaml files to markdown with expected frontmatter'
  task :yml2md do
    system!('bundle exec middleman contentful')
    # blog posts
    #
    Dir.glob('data/aptible/blog_posts/*.yaml') do |yml_file|
      # do work on files ending in .rb in the desired directory
      yml = YAML.load File.read(yml_file)
      File.open("source/blog/#{yml[:slug]}.md", 'w') do |blog_post|
        # Frontmatter
        blog_post << "---\n"
        blog_post << "title: \"#{yml[:title]}\"\n"
        blog_post << "excerpt: \"#{yml[:excerpt]}\"\n"
        blog_post << "author_name: #{yml[:author][:name]}\n"
        blog_post << "author_email: #{yml[:author][:email]}\n"
        blog_post << "author_id: #{yml[:author][:slug]}\n"
        blog_post << "posted: #{yml[:posted]}\n"
        blog_post << "section: Blog\n"
        blog_post << "posts: true\n"
        blog_post << "---\n"
        # Markdown
        blog_post << yml[:body]
      end
    end
  end
end

RSpec::Core::RakeTask.new(:spec)

require 'aptible/tasks'
Aptible::Tasks.load_tasks
