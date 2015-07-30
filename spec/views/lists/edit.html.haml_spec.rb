require 'rails_helper'

RSpec.describe "lists/edit", type: :view do
  before(:each) do
    @list = assign(:list, List.create!(
      :trello_id => "",
      :name => "",
      :closed => "",
      :position => ""
    ))
  end

  it "renders the edit list form" do
    render

    assert_select "form[action=?][method=?]", list_path(@list), "post" do

      assert_select "input#list_trello_id[name=?]", "list[trello_id]"

      assert_select "input#list_name[name=?]", "list[name]"

      assert_select "input#list_closed[name=?]", "list[closed]"

      assert_select "input#list_position[name=?]", "list[position]"
    end
  end
end
