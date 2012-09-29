desc "Import Movies."
task :import_movies => :environment do
  File.open("netflix.txt", "r").each do |line|
    title, year, language, synopsis, movie_url, poster_url, actor1, actor2 = line.force_encoding('binary').encode('utf-8', :invalid => :replace, :undef => :replace).strip.split("\t")
    u = Movie.new(:title => title, :year=> year, :language => language, :synopsis => synopsis, :remote_poster_url=>poster_url, :actor1=>actor1, :actor2=>actor2)
    u.save
    v = u.vods.create(:movie_url => movie_url, :platform_id => 1)
    v.save
  end
end

task :recreate_versions => :environment do
    Movie.all.each do |movie|
      movie.poster.recreate_versions!
    end
end


