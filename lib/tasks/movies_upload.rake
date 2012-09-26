desc "Import Movies."
task :import_movies => :environment do
    File.open("netflix.txt", "r").each do |line|
        title, year, language, synopsis, movie_url, poster_url = line.force_encoding('binary').encode('utf-8', :invalid => :replace, :undef => :replace).strip.split("\t")
        u = Movie.new(:title => title, :year=> year, :language => language, :synopsis => synopsis, :remote_poster_url=>poster_url)
        u.save
        v = u.vods.create(:movie_url => movie_url, :platform_id => 1)
        v.save
    end
end