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

# スプライト画像が保存された直後のコールバック
on_sprite_saved do |filename|
    # スプライト画像のファイル末に付くランダムな文字列を削除する
    if File.exists?(filename)
        FileUtils.cp filename, filename.gsub(%r{-s[a-z0-9]{10}\.png$}, '.png')
        FileUtils.rm_rf(filename)
    end
end

# スタイルシートが保存された直後のコールバック
on_stylesheet_saved do |filename|

    # スプライト画像のファイル末に付くランダムな文字列を削除する
    if File.exists?(filename)
        css = File.read filename
        File.open(filename, 'w+') do |f|
          f << css.gsub(/@charset.*;\n/, '').gsub(%r{-s[a-z0-9]{10}\.png}, '.png')
        end
    end
end
