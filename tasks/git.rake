require 'git'

working_directory = File.dirname(__FILE__)
repo = Git.open(working_directory)

namespace :git do
  
  desc "do something" do
    def files_to_be_committed?
      status = repo.status
      status.added.empty? && status.deleted.empty? && status.changed.empty?
    end
    def stuff
      repo.add('sdf')
      end     
  end
  
  desc "commit all added changes"
  task :commit do
    @git.commit
  end
  
  desc "add all untracked files"
  task :add do
    status_message = @git.run( "status", :capture_output => true, :silent => true)
    @git.run "add #{@git.extract_untracked_files(status_message).join(' ')}"
  end
  
  desc "rm all deleted files"
  task :del do
    status_message = @git.run( "status", :capture_output => true, :silent => true)
    @git.run "rm #{@git.extract_deleted_files(status_message).join(' ')}"
  end
  
  desc "display current change status"
  task :status do
    @git.run "status", :expect_error => true
  end
  
  desc "ignore a given file or list of files (or all files matching a quotations-surrounded regular expression)"
  task :ignore do
    ARGV.shift
    @git.ignore ARGV
    puts "Added #{ARGV.join(', ')} to .gitignore"
  end
end