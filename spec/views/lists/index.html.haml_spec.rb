require 'rails_helper'

RSpec.describe "lists/index", type: :view do
  before(:each) do
    assign(:lists, [
      List.create!(
        :trello_id => "",
        :name => "",
        :closed => "",
        :position => ""
      ),
      List.create!(
        :trello_id => "",
        :name => "",
        :closed => "",
        :position => ""
      )
    ])
  end

  it "renders a list of lists" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
