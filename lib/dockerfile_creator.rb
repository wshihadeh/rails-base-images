require 'fileutils'

module RailsBaseImages

  class DockerFilesCreator
    def config
      @config ||= YAML.load_file("#{RailsBaseImages.root}/config/images.yml")
    end

    def call
      config["images"].each do |image|
        RailsBaseImages.logger.info "Createing docker file for #{image['name']}"

        create_docker_file(image)
        RailsBaseImages.logger.info "Done"
      end
    end

    private

    def create_docker_file(image)
      docker_file_path = "#{image['name'].gsub!(':', '/')}"
      dockerfile = Dockerfile.new(
        ruby_version:    image["ruby_version"],
        additional_pkgs: image["additional_pkgs"],
        install_gems:    image["install_gems"],
      ).render

      FileUtils.mkdir_p(docker_file_path)
      File.open("#{docker_file_path}/Dockerfile", 'w') { |file| file.write(dockerfile) }
    rescue => e
      RailsBaseImages.logger.error "Failed: #{e.inspect}"
    end
  end
end
