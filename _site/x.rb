# make useless file ruby for gh identity it's ruby
#######################################################

case
when song.name == 'Misty'
  puts 'Not again!'
when song.duration > 120
  puts 'Too long!'
when Time.now.hour > 21
  puts "It's too late"
else
  song.play
end

kind = case year
       when 1850..1889 then 'Blues'
       when 1890..1909 then 'Ragtime'
       when 1910..1929 then 'New Orleans Jazz'
       when 1930..1939 then 'Swing'
       when 1940..1950 then 'Bebop'
       else 'Jazz'
       end

# bad
def self.create_translation(phrase_id, phrase_key, target_locale,
                            value, user_id, do_xss_check, allow_verification)
  ...
end

# good
def self.create_translation(phrase_id,
                            phrase_key,
                            target_locale,
                            value,
                            user_id,
                            do_xss_check,
                            allow_verification)
  ...
end

# good
def self.create_translation(
  phrase_id,
  phrase_key,
  target_locale,
  value,
  user_id,
  do_xss_check,
  allow_verification
)
  ...
end
# bad
result = func(a, b)# we might want to change b to c

# good
result = func(a, b) # we might want to change b to c

sum = 1 + 2
a, b = 1, 2
1 > 2 ? true : false; puts 'Hi'
[1, 2, 3].each { |e| puts e }

if @reservation_alteration.checkin == @reservation.start_date &&
   @reservation_alteration.checkout == (@reservation.start_date + @reservation.nights)

  redirect_to_alteration @reservation_alteration
end

# bad
class Foo

  def bar
    # body omitted
  end

end

# good
class Foo
  def bar
    # body omitted
  end
end

def transformorize_car
  car = manufacture(options)
  t = transformer(robot, disguise)

  car.after_market_mod!
  t.transform(car)
  car.assign_cool_name!

  fleet.add(car)
  car
end

# Automatic conversion of one locale to another where it is possible, like
# American to British English.
module Translation
  # Class for converting between text between similar locales.
  # Right now only conversion between American English -> British, Canadian,
  # Australian, New Zealand variations is provided.
  class PrimAndProper
    def initialize
      @converters = { :en => { :"en-AU" => AmericanToAustralian.new,
                               :"en-CA" => AmericanToCanadian.new,
                               :"en-GB" => AmericanToBritish.new,
                               :"en-NZ" => AmericanToKiwi.new,
                             } }
    end

  ...

  # Applies transforms to American English that are common to
  # variants of all other English colonies.
  class AmericanToColonial
    ...
  end

  # Converts American to British English.
  # In addition to general Colonial English variations, changes "apartment"
  # to "flat".
  class AmericanToBritish < AmericanToColonial
    ...
  end
All files, including data and config files, should have file-level comments.

# List of American-to-British spelling variants.
#
# This list is made with
# lib/tasks/list_american_to_british_spelling_variants.rake.
#
# It contains words with general spelling variation patterns:
#   [trave]led/lled, [real]ize/ise, [flav]or/our, [cent]er/re, plus
# and these extras:
#   learned/learnt, practices/practises, airplane/aeroplane, ...


# bad
def obliterate(things, gently = true, except = [], at = Time.now)
  ...
end

# good
def obliterate(things, gently: true, except: [], at: Time.now)
  ...
end

# good
def obliterate(things, options = {})
  options = {
    :gently => true, # obliterate with soft-delete
    :except => [], # skip obliterating these things
    :at => Time.now, # don't obliterate them until later
  }.merge(options)

  ...
end

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end
end
         
 # encoding: utf-8

begin
  require 'bundler/setup'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler"
  exit -1
end

LANGUAGES = %w[bg de en es fr id it ja ko pl pt ru tr vi zh_cn zh_tw]
CONFIG = "_config.yml"

task :default => [:build]
task :ci      => [:test, :build]

desc "Build the Jekyll site"
task :build do
  require "lanyon"

  Lanyon.build
end

namespace :build do

  def build_subpage(lang)
    require "yaml"
    require "lanyon"

    exclude_config = YAML.load_file(CONFIG)["exclude"]
    exclude_langs  = (LANGUAGES - [lang]).map {|x| "#{x}/" }

    exclude = exclude_config + exclude_langs

    Lanyon.build(exclude: exclude)
  end

  desc "Build the Jekyll site (`lang' language part only)"
  task :lang do
    puts 'Please specify one of the valid language codes:'
    puts LANGUAGES.join(', ') << '.'
  end

  LANGUAGES.each do |lang|
    task lang.to_sym do
      build_subpage(lang)
    end
  end
end

desc "Serve the Jekyll site locally"
task :serve do
  sh "rackup config.ru"
end

namespace :new_post do

  def create_template(lang)
    url_title = 'short-title'
    title = 'Post Title'

    now = Time.now.utc
    datetime = now.strftime("%Y-%m-%d %H:%M:%S %z")
    date = now.strftime("%Y-%m-%d")
    filename = "#{date}-#{url_title}.md"
    path = File.join(lang, 'news', '_posts', filename)

    content = <<-TEMPLATE.gsub(/^ */, '')
      ---
      layout: news_post
      title: "#{title}"
      author: "Unknown Author"
      translator:
      date: #{datetime}
      lang: #{lang}
      ---
      Content.
    TEMPLATE

    $stderr.print "Creating template `#{path}'... "
    begin
      if File.exist?(path)
        warn "Could not create template, `#{path}' already exists."
      else
        File.open(path, 'w') {|f| f.write content }
        warn 'done.'
      end
    rescue => e
      warn e.message
    end
  end

  desc "Create a news post template for language `lang'"
  task :lang do
    puts 'Please specify one of the valid language codes:'
    puts LANGUAGES.join(', ') << '.'
  end

  LANGUAGES.each do |lang|
    task lang.to_sym do
      create_template(lang)
    end
  end
end

desc "Alias for `check'"
task :test => [:check]

desc "Run some tests on markdown files"
task :check do
  require_relative "lib/linter"
  Linter.new.run
end

namespace :check do

  localport = 9292

  desc "Check for broken internal links on http://localhost:#{localport}/"
  task :links do
    require_relative "lib/link_checker"
    LinkChecker.new.check(localport: localport, languages: LANGUAGES)
  end

  desc 'Validate _site markup with validate-website'
  task :markup do
    require_relative "lib/markup_checker"
    MarkupChecker.new.check
  end
end
