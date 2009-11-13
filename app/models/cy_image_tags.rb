module CyImageTags
  include Radiant::Taggable
  
  require 'RMagick'
  
  class CyImageTagError < StandardError; end
  
  begin # CyImage Tags:
    desc %{ All CyImage-related tags live inside this one. }
    tag "cy_image" do |tag|
      tag.expand
    end
    
    tag "cy_image:thumbnail" do |tag|
      width = tag.attr['width'].to_i
      height = tag.attr['height'].to_i
      image_cache = ImageCache.new(tag.attr['src'], tag.attr['width'], tag.attr['height'], 'thumbnail')
      if (!image_cache.cache_exists?)
        img =  Magick::Image.read(RAILS_ROOT + tag.attr['src']).first
        img.crop_resized!(width, height)
        img.write(image_cache.get_cache_path)
      end
      attr_updated = {'src' => image_cache.url}
      generate_tag(tag.attr.merge(attr_updated))
    end
    
    tag "cy_image:resize" do |tag|
      width = tag.attr['width'].to_i
      height = tag.attr['height'].to_i
      image_cache = ImageCache.new(tag.attr['src'], tag.attr['width'], tag.attr['height'], 'resize')
      if (!image_cache.cache_exists?)
        img =  Magick::Image.read(RAILS_ROOT + tag.attr['src']).first
        if (height > 0 && width > 0)
          img.resize!(width, height)
        else
          if (width > 0)
            scale = width / img.x_resolution
            img.scale!(scale)
          else
            scale = height / img.y_resolution
            img.scale!(scale)
          end
        end
        img.write(image_cache.get_cache_path)
      end
      attr_updated = {'src' => image_cache.url}
      generate_tag(tag.attr.merge(attr_updated))
    end
  end
  
  protected
  
  def generate_tag(attributes)
    attr_str = ""
    attributes.stringify_keys.each do |name, value|
      attr_str << %Q(#{name.to_s}="#{value.to_s}" )
    end
    result = %Q{<img #{attr_str}/>}
  end

end
