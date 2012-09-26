require 'spec_helper'

describe "movies/show" do
  before(:each) do
    @movie = assign(:movie, stub_model(Movie,
      :title => "Title",
      :year => "",
      :language => "Language",
      :image => "Image",
      :actor1 => "Actor1",
      :actor2 => "Actor2",
      :director => "Director",
      :synopsis => "Synopsis"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(//)
    rendered.should match(/Language/)
    rendered.should match(/Image/)
    rendered.should match(/Actor1/)
    rendered.should match(/Actor2/)
    rendered.should match(/Director/)
    rendered.should match(/Synopsis/)
  end
end
