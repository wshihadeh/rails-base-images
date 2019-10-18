require "erb"
require "yaml"
require "logger"

require_relative "./dockerfile"
require_relative "./dockerfile_creator"

module RailsBaseImages
  extend self

  def root
    File.expand_path(File.join(File.dirname(__FILE__), '..')).freeze
  end

  def logger
    @logger ||= Logger.new(STDOUT).tap { |l| l.level = Logger::INFO }
  end
end
