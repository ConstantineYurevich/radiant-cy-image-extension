namespace :radiant do
  namespace :extensions do
    namespace :cy_image do
      
      desc "Runs the migration of the Cy Image extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          CyImageExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          CyImageExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Cy Image to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from CyImageExtension"
        Dir[CyImageExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(CyImageExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
