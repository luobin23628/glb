require 'sub_command'


module Gitl

  class Update < SubCommand

    self.summary = '根据yml配置，更新代码'

    self.description = <<-DESC
      根据yml配置，更新代码.
    DESC

    def run
      self.config.projects.each do |project|
        project_path = File.expand_path(project.name, './')

        if File.exist?(project_path)
          puts project.name + ' exists, skip.'
          g = Git.open(project_path)
          g.pull("origin", g.current_branch)

        else
          raise Error.new("please run gitl init.")
        end

      end
    end

  end
end