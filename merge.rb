require 'fileutils'

class Repo
    attr_accessor :git_repo, :dir_name, :front_end_dir
    def initialize(git_repo,dir_name,front_end_dir)
        @git_repo = git_repo
        @dir_name = dir_name
        @front_end_dir = front_end_dir
    end
end

def search_replace_in_file_path(search, replace, file_path)
    data = File.read(file_path) 
    filtered_data = data.gsub(search, replace) 
    File.open(file_path, "w") do |f|
        f.write(filtered_data)
    end
end

if ARGV.size < 2 then
    puts 'merge.rb [branch_name] [commit_message]'
    exit
end

branch_name = ARGV[0]
commit_message = ARGV[1]

ruby = Repo.new(
    'git@github.com:twiliodeved/sdk-starter-ruby.git',
    'ruby_repo',
    'public'
)

python = Repo.new(
    'git@github.com:twiliodeved/sdk-starter-python.git',
    'python_repo',
    'static'
)

java = Repo.new(
    'git@github.com:twiliodeved/sdk-starter-java.git',
    'java_repo',
    'src/main/resources/public'
)

php = Repo.new(
    'git@github.com:twiliodeved/sdk-starter-php.git',
    'php_repo',
    'webroot'
)

front_end = Repo.new(
    'git@github.com:twiliodeved/sdk-starter-node.git',
    'node_repo',
    'public'
)

server_repos = [ruby,php,java,python]
all_repos = [front_end,ruby,php,java,python]

tmp_dir = "tmp"

FileUtils.rm_rf(tmp_dir, secure: true)

FileUtils.mkdir tmp_dir

# clone the git repos
all_repos.each do |repo|
    system "git clone #{repo.git_repo} #{tmp_dir}/#{repo.dir_name}"
end

# create new branches on the server repos
server_repos.each do |repo|
    system "cd #{tmp_dir}/#{repo.dir_name} && git checkout -b #{branch_name}"
end

# copy in the front end code
server_repos.each do |repo|
    puts "copying front end files into #{repo.dir_name}"
    FileUtils.cp_r "#{tmp_dir}/#{front_end.dir_name}/#{front_end.front_end_dir}/.", "#{tmp_dir}/#{repo.dir_name}/#{repo.front_end_dir}"  
end

# process files for special cases
# PHP 
php_front_end_dir = "#{tmp_dir}/#{php.dir_name}/#{php.front_end_dir}"
php_config_check_js_path = "#{php_front_end_dir}/config-check.js"
search_replace_in_file_path("'/config'","'/config-check.php'",php_config_check_js_path)
search_replace_in_file_path("'Not configured in .env'","'Not configured in config.php'",php_config_check_js_path)

php_chat_index_js_path = "#{php_front_end_dir}/chat/index.js"
search_replace_in_file_path("'/token'","'/token.php'",php_chat_index_js_path)

php_sync_index_js_path = "#{php_front_end_dir}/sync/index.js"
search_replace_in_file_path("'/token'","'/token.php'",php_sync_index_js_path)

php_video_quickstart_js_path = "#{php_front_end_dir}/video/quickstart.js"
search_replace_in_file_path("'/token'","'/token.php'",php_video_quickstart_js_path)

php_notify_notify_js_path = "#{php_front_end_dir}/notify/notify.js"
search_replace_in_file_path("'/send-notification'","'/send-notification.php'",php_notify_notify_js_path)

# create commits
server_repos.each do |repo|
    system "cd #{tmp_dir}/#{repo.dir_name} && git add . && git commit -m '#{commit_message}'"
end

# push to github
server_repos.each do |repo|
    system "cd #{tmp_dir}/#{repo.dir_name} && git push origin #{branch_name}"
end