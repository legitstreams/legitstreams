desc "Update Movies."


task :check_remove_duplicate_movies => :environment do

  Movie.all.each do |movie|
    if (movie_id = check_duplicate_titles(movie.title,movie.language,movie.year,movie.id))!= nil

      puts "Duplicate Found"
      @vods = Vod.find_all_by_movie_id(movie_id)

      @vods.each do |vod|
        vod.movie_id = movie.id
        vod.save!
      end
    end
  end
end


task :remove_movies_null_platforms => :environment do

  Movie.all.each do |movie|
    if movie.vods.count == 0
      puts movie.title + " - " + movie.vods.count.to_s
      movie.destroy
    end
  end
end

task :update_no_of_platforms => :environment do

  Movie.all.each do |movie|
       movie.no_of_platforms = movie.vods.count
       puts movie.title + "-" + movie.vods.count.to_s
       movie.save!
       movie.reload
  end
end



task :recreate_versions => :environment do
    Movie.all.each do |movie|
      movie.poster.recreate_versions!
    end
end

task :delete_movies  => :environment do
  Movie.delete_all
  Vod.delete_all
  Actor.delete_all
end




def check_duplicate_titles(movie_title,language,year, movie_id)

      Movie.all.each do |movie|
        distancestr = Text::Levenshtein.distance(movie_title, movie.title)
        if (distancestr < 2)&&(language == movie.language) && (year == movie.year) && (movie.id != movie_id)
          puts "Duplicate Movie =" + movie.title
          return movie.id
        end
      end
      return nil
end

