require 'text'
require 'text/levenshtein'

class TxtDb
  class << self
    include Text::Levenshtein
    def upload_movies(txt_data)

          txt_data.read.each_line do |line|
          title, year, language, synopsis, portal_url, movie_url, poster_url, director, actor_list = line.force_encoding('binary').encode('utf-8', :invalid => :replace, :undef => :replace).strip.split("\t")
          puts title

          if (movie_id = check_duplicate_title_in_movies(title,language,year))== nil

              puts "Duplicate Not Found"
              u = Movie.new(:title => title, :year=> year, :language => language, :synopsis => synopsis, :remote_poster_url=>poster_url, :director => director)
              u.save

              v = u.vods.build(:movie_url => movie_url, :platform_id => Platform.find_by_base_url(portal_url).id)
              v.save

              unless actor_list.nil?
                          actors_split = actor_list.force_encoding('binary').encode('utf-8', :invalid => :replace, :undef => :replace).strip.split(",")
                          actors_split.each do |actor_name|
                            #puts actor_name.gsub(/"|^ +| $+|\n/i,'').to_s
                            a = u.actors.build(:name => actor_name.gsub(/"|^ +| $+|\n/i,'').to_s)
                            a.save
                          end
              end
          else
            puts "Duplicate Found"
            v = Vod.new(:movie_id => movie_id, :movie_url => movie_url, :platform_id => Platform.find_by_base_url(portal_url).id)
            v.save
          end

      end
    end

    def check_duplicate_title_in_movies(movie_title,language,year)

          Movie.all.each do |movie|
            distancestr = Text::Levenshtein.distance(movie_title, movie.title)
            if (distancestr < 2)&&(language == movie.language) && (year == movie.year)
              puts "Duplicate Movie =" + movie.title
              return movie.id
            end
          end
          return nil
    end




  end
end