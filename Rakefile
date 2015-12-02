require "bundler/gem_tasks"

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
  
  desc 'Increment minor version'
  task :incv do
    relpath = File.join 'lib', 'parse_sberbank_html', 'version.rb'
    path = File.join File.dirname(__FILE__), relpath
    data = File.read path
    version_match = data.match /VERSION = "(\d+\.\d+)\.(\d+)"/
    unless version_match
      raise 'Could not parse version file'
    end
    
    version_prefix = version_match[1]
    version_minor = Integer(version_match[2])
    next_version_minor = version_minor + 1
    puts "version minor: #{version_prefix}.#{version_minor} -> #{version_prefix}.#{next_version_minor}"
    
    increment_ok = data.gsub! /VERSION = "(\d+\.\d+)\.(\d+)"/, "VERSION = \"\\1.#{next_version_minor}\""
    unless increment_ok
      raise 'Could not increment version value'
    end
    
    puts data
    File.write path, data
    
    sh "git add #{relpath}"
    sh "git commit -m 'v#{version_prefix}.#{next_version_minor}'"
  end
rescue LoadError
  # No rspec
end

