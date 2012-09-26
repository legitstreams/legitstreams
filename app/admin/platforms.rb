
ActiveAdmin.register Platform do

  index do
    column "Platform Name" do |platform|
      link_to platform.name, admin_platform_path(platform)
    end
    column "Logo" do |platform|
         image_tag(platform.logo_url(:thumb))
    end
    column "Website", :base_url
    default_actions

  end

  show do |platform|
        attributes_table do
               row  :name
               row :logo do
                 image_tag(platform.logo_url(:thumb))
               end
               row :base_url
        end
        #active_admin_comments
        panel "Now Plalying" do
         table_for platform.vods do
            column "Movie Title" do |vod|
              link_to vod.movie.title, admin_movie_path(vod.movie)
            end
            column "Year" do |vod|
              vod.movie.year
            end
            column "Language" do |vod|
              vod.movie.language
            end
            column "Actor1" do |vod|
              vod.movie.actor1
            end
            column "Actor2" do |vod|
              vod.movie.actor2
            end
            column "Poster Image" do |vod|
              image_tag(vod.movie.poster_url(:thumb))
            end
            column :movie_url
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
   end


  form  :html => { :multipart => true } do |f|
          f.inputs "Platforms" do
          f.input :name
          f.input :base_url
          f.input :logo, :as => :file, :label => "Platform Logo" , :label => "Logo"
          f.input :remote_logo_url, :label => "Or URL to Platform Logo"
      end

      f.buttons

  end

end
