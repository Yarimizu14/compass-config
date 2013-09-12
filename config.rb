# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "stylesheets"
sass_dir = "sass"
images_dir = "images"
javascripts_dir = "javascripts"
relative_assets = false
asset_cache_buster = :none

# ==== Added Configuration below ====

# .sass-cacheを作成しない
cache = false

# 戻り値として返した文字列が対象の画像URL末尾に追加される
asset_cache_buster do |http_path, real_path|
    "hoge"
end

sprites = Array.new

# スプライト画像が保存された直後のコールバック
on_sprite_saved do |filename|
    sprites << filename
end

# スタイルシートが保存された直後のコールバック
on_stylesheet_saved do |filename|
    # スプライト画像のファイル末に付くランダムな文字列を削除する
    for sprite in sprites do
        if File.exists?(sprite)
            FileUtils.cp sprite, sprite.gsub(%r{-s[a-z0-9]{10}\.png$}, '.png')
            FileUtils.rm_rf(sprite)
        end
    end

    # スプライト画像のファイル末に付くランダムな文字列を削除する
    if File.exists?(filename)
        css = File.read(filename, :encoding => Encoding::UTF_8)
        File.open(filename, 'w+:utf-8') do |f|
          f << css.gsub(/@charset.*;\n/, '').gsub(%r{-s[a-z0-9]{10}\.png}, '.png')
          #f << css.gsub(%r{-s[a-z0-9]{10}\.png}, '.png')
        end
    end
end

