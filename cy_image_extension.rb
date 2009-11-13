# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class CyImageExtension < Radiant::Extension
  version "0.1.0"
  description "Image resizing using ImageMagick"
  url "http://yourwebsite.com/cy_image"
  
  def activate
    Page.send :include, CyImageTags
  end
  
  def deactivate
  end
  
end
