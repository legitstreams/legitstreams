ActiveAdmin.register Movie do

  filter :title
  filter :year
  filter :language
  filter :vods_platform_name, :label=>"Platform Name", :as => :string

  config.sort_order = "title_asc"
  config.paginate = 50

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
    debug(params) if Rails.env.development?
  end


  sidebar "Starring Actors", :only=> :show do
    table_for movie.actors do
      column "Actor Name" do |actor|
        actor.name
      end
      column "" do |actor|
         link_to "Remove", admin_actor_path(actor), confirm: 'Are you sure?', method: :delete
       end
       column "" do |actor|
         link_to "Edit", edit_admin_actor_path(actor)
       end
    end
  end

  sidebar "Now Plalying At", :only=>:show do
       table_for movie.vods do
         column "Platform" do |vod|
           vod.platform.name
         end
         column "Video URL" do |vod|
          link_to truncate(vod.movie_url,:length=> 20),vod.movie_url,:target=>"_blank"
         end
         column "" do |vod|
           link_to "Remove", admin_vod_path(vod), confirm: 'Are you sure?', method: :delete
         end
         column "" do |vod|
           link_to "View", admin_vod_path(vod)
         end
         column "" do |vod|
           link_to "Edit", edit_admin_vod_path(vod)
         end
       end
  end

  form  :html => { :multipart => true } do |f|
          f.inputs "Movies" do
              f.input :title,:label => "Movie Title", :input_html => {:rows => 1 }
              f.input :year
              f.input :language
              #f.input :actor1
              #f.input :actor2
              f.input :director
              f.input :synopsis, :as => :text, :input_html => {:rows => 10}
              f.input :poster, :as => :file, :label => "Movie Poster" , :label => "Image"
              f.input :remote_poster_url, :label => "OR URL TO Poster Image"
              f.buttons
          end

          f.inputs "ACTORS"  do
            f.has_many :actors do |a|

                  a.input :name, :label => false
                  if !a.object.nil?
                      a.input :_destroy, :as => :boolean, :label => "Destroy?"
                  end
                  a.buttons
            end

          end


    f.inputs "VODS" do
        f.has_many :vods do |p|
                p.input :movie_url, :label=>"Video URL", :input_html => {:size => 600 }
                p.input :platform , :label=>false
                if !p.object.nil?
                    p.input :_destroy, :as => :boolean, :label => "Destroy?"
                end
                p.buttons
        end
    end

    f.buttons


  end
end

