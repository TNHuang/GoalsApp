require 'spec_helper'
require 'rails_helper'

feature "goals" do

  before :each do
    sign_up_as_kenny
  end

  it 'should allow us to create a new goal' do
    expect(page).to have_link('Create New Goal')
  end


  feature "new goals" do
    before(:each) do
     click_link('Create New Goal')
    end

    it 'has a create new goal page' do
      expect(page).to have_content("Create New Goal")
    end

    it 'takes a title' do
      expect(page).to have_content("Title")
    end

    it "takes a body" do
      expect(page).to have_content("Body")
    end

    it "takes a private status" do
      expect(page).to have_content("Private")
    end

    it "takes a public status" do
      expect(page).to have_content("Public")
    end

    it "has a submit button" do
      expect(page).to have_button "Submit Goal"
    end

  end


  feature "CRUD goal" do
    before :each do
      click_link('Create New Goal')
      fill_in("Title", with: "Try to take over the world")
      fill_in("Body", with: "The same thing we do every night, pinky.")
      choose("Public")
      click_button("Submit Goal")
    end

    feature "create goal" do
      it "redirects back to user show page" do
        expect(page).to have_content("Goals")
      end
    end

    feature "read goals" do
      it "should able to see a created goals" do
        expect(page).to have_content("Try to take over the world")
        expect(page).to have_content("The same thing we do every night, pinky.")
      end

      it "has a link to edit each goal" do
        expect(page).to have_link("Edit Goal")
      end

      it "has a link to destroy each goal" do
        expect(page).to have_button("Destroy Goal")
      end

    end

    feature "update goal" do

      before :each do
        click_link("Edit Goal")
      end


      it "has our current values" do
        expect(page).to have_field("Title", with: "Try to take over the world")
        expect(page).to have_field("Body", with: "The same thing we do every night, pinky.")
        # radios?
      end

      it "has a submit button" do
        expect(page).to have_button("Update Goal")
      end

      it "rejects an empty title" do
        fill_in("Title", with: "")
        click_button("Update Goal")
        expect(page).to have_content("Title can't be blank")
      end

      it "successfully updates a goal" do
        fill_in("Title", with: "Try to take over the world, narf")
        fill_in("Body", with: "Are you thinking what I'm thinking, pinky?")
        click_button "Update Goal"
        expect(page).to have_content( "Try to take over the world, narf")
        expect(page).to have_content( "Are you thinking what I'm thinking, pinky?")
      end

    end

    feature "destroy goal" do

    end
  end





  # it 'should be able to see goals' do
  #   expect(page).to have_content()
  # end
end