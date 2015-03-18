require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'byebug'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      file_name = "#{template_name}.html.erb"
      file_path_and_name = File.join(
        File.dirname(__FILE__),
        '..',
        '..',
        'views',
        "#{self.class.to_s.underscore}",
        file_name
      )

      file = File.read(file_path_and_name)
      erb_file = ERB.new(file)

      render_content(erb_file.result(binding), 'text/html')
    end
  end
end
