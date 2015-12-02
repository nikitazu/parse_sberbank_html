require "bundler/gem_tasks"

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
  
  desc 'Increment minor version'
  task :incv do
    path = File.join File.dirname(__FILE__), 'lib', 'parse_sberbank_html', 'version.rb'
    data = File.read path
    version_match = data.match /VERSION = "\d+\.\d+\.(\d+)"/
    unless version_match
      raise 'Could not parse version file'
    end
    
    version_minor = Integer(version_match[1])
    next_version_minor = version_minor + 1
    puts "version minor: #{version_minor} -> #{next_version_minor}"
    
    increment_ok = data.gsub! /VERSION = "(\d+\.\d+)\.(\d+)"/, "VERSION = \"\\1.#{next_version_minor}\""
    unless increment_ok
      raise 'Could not increment version value'
    end
    
    puts data
    File.write path, data
  end
rescue LoadError
  # No rspec
end

