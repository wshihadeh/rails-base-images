module RailsBaseImages
  class Dockerfile
    attr_accessor :ruby_version, :additional_pkgs, :install_gems

    def initialize(attributes = {})
      attributes.each do |key, value|
        public_send("#{key}=", value)
      end
    end

    def install_gems
      @install_gems || ['bundler']
    end

    def render
      renderer.result(binding)
    end

    private

    def renderer
      ERB.new(File.read("#{RailsBaseImages.root}/templates/Dockerfile.erb"))
    end
  end
end
