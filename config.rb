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

# スプライト画像が保存された直後のコールバック
on_sprite_saved do |filename|
    # スプライト画像のファイル末に付くランダムな文字列を削除する
    if File.exists?(filename)
        FileUtils.cp filename, filename.gsub(%r{-s[a-z0-9]{10}\.png$}, '.png')
        # Note: Compass outputs both with and without random hash images.
        # To not keep the one with hash, add: (Thanks to RaphaelDDL for this)
        FileUtils.rm_rf(filename)
    end
end

# スプライト画像が生成された直後のコールバック
on_sprite_generated do |filename|
    nil
end


# スタイルシートが保存された直後のコールバック
on_stylesheet_saved do |filename|

    # @cahrsetが出力された場合は削除する
    results = system("sed".concat(" -i '' -e '/@charset.*;/d' ").concat(filename))
    #results = system("sed".concat(" -i '' -n -e 's/@charset.*;//g' ").concat(filename))

    # @cahrsetが出力された場合は削除する（windowsなどでsedコマンドがない場合）
    if !results then
        out = ""
        File.open(filename, "r") do |io|
            line = io.read
            c = line.match("@charset")
            if c.nil? then
                out.concat(line)
            else
                out.concat(line.gsub(/@charset.*;/, ""))
            end
        end

        File.open(filename, "w") do |io|
            io.write(out)
        end
    end


    # スプライト画像のファイル末に付くランダムな文字列を削除する
    if File.exists?(filename)
        css = File.read filename
        File.open(filename, 'w+') do |f|
          f << css.gsub(/@charset.*;\n/, '').gsub(%r{-s[a-z0-9]{10}\.png}, '.png')
          #f << css.gsub(%r{-s[a-z0-9]{10}\.png}, '.png')
        end
    end
end


