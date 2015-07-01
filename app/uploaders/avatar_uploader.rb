# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  storage :file
  
  def store_dir
    Settings.user.avatar.store_dir
  end

  def extension_white_list
    Settings.user.avatar.extension_white_list
  end
end
