# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class CyImageExtension < Radiant::Extension
  version "0.1.0"
  description "Image resizing using ImageMagick"
  url "http://github.com/ConstantineYurevich/radiant-cy-image-extension"
  
  def activate
    Page.send :include, CyImageTags
  end
  
  def deactivate
  end
  
end
