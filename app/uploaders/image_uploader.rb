class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 画像サイズの制限
  process resize_to_fit: [800, 800]

  # サムネイルの生成
  version :thumb do
    process resize_to_fill: [200, 200]
  end

  # 許可する拡張子
  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end