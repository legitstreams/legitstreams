ActiveAdmin.register Movie do

  index do
      column "Movie Title" do |movie|
        link_to movie.title, admin_movie_path(movie)
      end
      column "Year", :year
      column "Language", :language
      #column "Actor-1", :actor1
      #column "Actor-2", :actor2
      column "Poster Image" do |movie|
           image_tag(movie.poster_url(:thumb))
      end
      default_actions
  end


  show do
    attributes_table do
      row :title
      row :year
      row :language
      #row :actor1
      #row :actor2
      row :director
      row :poster do
          image_tag(movie.poster_url(:movie_poster))
      end
      row :synopsis
    end

    panel "Starring Actors" do
      table_for movie.actors do
        column "Actor Name" do |actor|
          actor.name
        end
      end
    end

    panel "Now Plalying At" do
      table_for movie.vods do
        column "Platform Name" do |vod|
          vod.platform.name
        end
        column :movie_url
      end
    end

    debug(params) if Rails.env.development?


  end


  form  :html => { :multipart => true } do |f|
          f.inputs "Movies" do
              f.input :title
              f.input :year
              f.input :language
              #f.input :actor1
              #f.input :actor2
              f.input :director
              f.input :synopsis, :as => :text
              f.input :poster, :as => :file, :label => "Movie Poster" , :label => "Image"
              f.input :remote_poster_url, :label => "OR URL TO Poster Image"
          end

          f.has_many :actors do |a|
              f.inputs "ACTORS" do
                  if !a.object.nil?
                    a.input :_destroy, :as => :boolean, :label => "Destroy?"
                  end
                  a.input :name
              end
          end


    f.has_many :vods do |p|
        f.inputs "VODS" do
            if !p.object.nil?
              p.input :_destroy, :as => :boolean, :label => "Destroy?"
            end
            p.input :movie_url
            p.input :platform
        end
    end

    f.buttons


  end
end

