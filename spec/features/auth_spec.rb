require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit "/users/new"
  end

  it "has a new user page" do
    expect(page).to have_content("Create New User")
  end


  it "should have username and password" do
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
  end

  it "should have a submit button" do
    expect(page).to have_button("Sign Up")
  end

  it "should validate the presence of user's username" do
    click_button 'Sign Up'
    expect(page).to have_content("Create New User")
    expect(page).to have_content("Username can't be blank")
  end


  it "should reject a blank password" do
    fill_in('Username', with: 'kenny')

    click_button "Sign Up"
    expect(page).to have_content("Password is too short")
  end

  it "should validate password length greater than 6" do
    fill_in('Username', with: 'kenny')
    fill_in('Password', with: 'kenny')
    click_button "Sign Up"
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
  end


  feature "signing up a user" do
    #sign up as some user

    it "shows username on the homepage after signup" do
      sign_up_as_kenny
      visit "/"
      expect(page).to have_content("Welcome kenny")
    end

  end

end

feature "logging in" do

  it "shows username on the homepage after login"

end

feature "logging out" do

  it "begins with logged out state"

  it "doesn't show username on the homepage after logout"

end
