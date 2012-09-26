require 'spec_helper'

describe "movies/new" do
  before(:each) do
    assign(:movie, stub_model(Movie,
      :title => "MyString",
      :year => "",
      :language => "MyString",
      :image => "MyString",
      :actor1 => "MyString",
      :actor2 => "MyString",
      :director => "MyString",
      :synopsis => "MyString"
    ).as_new_record)
  end

  it "renders new movie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => movies_path, :method => "post" do
      assert_select "input#movie_title", :name => "movie[title]"
      assert_select "input#movie_year", :name => "movie[year]"
      assert_select "input#movie_language", :name => "movie[language]"
      assert_select "input#movie_image", :name => "movie[image]"
      assert_select "input#movie_actor1", :name => "movie[actor1]"
      assert_select "input#movie_actor2", :name => "movie[actor2]"
      assert_select "input#movie_director", :name => "movie[director]"
      assert_select "input#movie_synopsis", :name => "movie[synopsis]"
    end
  end
end
