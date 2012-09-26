require 'spec_helper'

describe "movies/index" do
  before(:each) do
    assign(:movies, [
      stub_model(Movie,
        :title => "Title",
        :year => "",
        :language => "Language",
        :image => "Image",
        :actor1 => "Actor1",
        :actor2 => "Actor2",
        :director => "Director",
        :synopsis => "Synopsis"
      ),
      stub_model(Movie,
        :title => "Title",
        :year => "",
        :language => "Language",
        :image => "Image",
        :actor1 => "Actor1",
        :actor2 => "Actor2",
        :director => "Director",
        :synopsis => "Synopsis"
      )
    ])
  end

  it "renders a list of movies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Actor1".to_s, :count => 2
    assert_select "tr>td", :text => "Actor2".to_s, :count => 2
    assert_select "tr>td", :text => "Director".to_s, :count => 2
    assert_select "tr>td", :text => "Synopsis".to_s, :count => 2
  end
end
