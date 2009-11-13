class ImageCache 
  
  CY_IMAGE_CACHE_DIR = '/public/images/cy_image/cache/' 
  CY_IMAGE_CACHE_URL = '/images/cy_image/cache/' 
  
  def initialize(src, width, height, resize_type)
    @src = '/public/' + src.gsub(/^\/+/, '')
    @width = width
    @height = height
    @resize_type = resize_type
    set_extension
    set_cache_name
  end
  
  def set_extension
    @ext = @src.split('.').last
  end
  
  def set_cache_name
    require 'digest/md5'
    
    parts = @src.split('/')
    @cache_name = parts.last.gsub('.' + @ext, '') + '_' + Digest::MD5.hexdigest([@src, @width, @height, @resize_type].join('_')) + '.' + @ext
  end
  
  def get_cache_name
    return @cache_name
  end
  
  def get_cache_path
    return RAILS_ROOT + CY_IMAGE_CACHE_DIR + get_cache_name
  end
  
  def get_cache_url
    return CY_IMAGE_CACHE_URL + get_cache_name
  end
  
  def cache_exists?
    return File.exists?(get_cache_path)
  end
  
  def url
    if (cache_exists?)
      return get_cache_url
    end
  end
  
end