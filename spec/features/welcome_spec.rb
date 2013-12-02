require 'spec_helper'
#  _______  _______  _______  __   __  _     _  __   __  _______  ______
# |       ||   _   ||       ||  | |  || | _ | ||  | |  ||   _   ||      |
# |       ||  |_|  ||    _  ||  |_|  || || || ||  |_|  ||  |_|  ||___   |
# |       ||       ||   |_| ||       ||       ||       ||       |  __|  |
# |      _||       ||    ___||_     _||       ||       ||       | |_____|
# |     |_ |   _   ||   |      |   |  |   _   ||   _   ||   _   |   __
# |_______||__| |__||___|      |___|  |__| |__||__| |__||__| |__|  |__|
# http://jnicklas.github.io/capybara/
# (\~---.
#  /   (\-`-/)
# (      ' ' )
#  \ (  \_Y_/\
#   ""\ \___//
#      `w   "
describe "The Home Page" do

  before(:each) do
    visit '/'
  end

  it "says 'hello and welcome'" do
    expect(page).to have_content("hello and welcome")
  end

  it "has the title 'Week 10'" do
    expect(page).to have_title "Week 10"
  end

  it "has a link to /javascript" do
    find_link('JavaScript').click
    expect(page).to have_content('Java Jive')
    expect(current_path).to eq('/javascript')
  end

  # There should be a link on the home page called "quizzes"
  # When a user clicks on "quizzes" they should be re-directed to "/quizzes"
  it "has a link to quizzes" do
    find_link('Quizzes').click
    expect(page).to have_content('Quizzes')
    expect(current_path).to eq('/quizzes')
  end

end

describe 'A page called JavaScript' do

  before(:each) do
    visit '/javascript'
  end

  it "Has an h1 with the text 'Java Jive'" do
    h1 = page.find('h1')
    text = 'Java Jive'
    expect(h1.has_content?(text)).to be true
  end

  it "has a button labeled 'Click Me!'" do
    button = page.find('button')
    label = 'Click Me!'
    expect(button.has_content?(label)).to be true
  end

  describe "clicking the button with JavaScript enabled", :js => true do

    before(:each) do
      click_button('Click Me!');
    end

    it "changes the h1's text to Jabba Jive using jQuery" do
      expect(page).to have_content('Jabba Jive')
      expect(page).to have_no_content('Java Jive')
    end

    it "changes the body's background to pink", :js => true do
      expect(page).to have_css('body.pink')
    end

    it "disables the button", :js => true do
      button = page.find('button')
      expect(button.disabled?).to be true
    end

  end

end

describe "a page called Quizzes" do

  before(:each) do
    visit '/quizzes'
  end

  # "/quizzes" should have an input field and a button labeled 'calc'
  # "/quizzes" should not have a form tag
  it "has an input field and a button labeled calc and no form" do
    expect(page).to have_css('input')
    expect(page).to have_button('calc')
    expect(page).to_not have_css('form')
  end

  # We should be able to fill in a series of numbers separated by commas into the input field and click "calc"
  it "accepts a series of numbers seperated by commas as the input value when clicking calc" do
    page.fill_in 'numbers', :with => '1,2,3'
    value = find_field('numbers').value
    expect(value).to eq('1,2,3')
  end

  # The numbers entered should be evaluated by a javascript function called check_increasing
  # If the numbers entered are sorted and ascending the body's background should turn green
  # else the body's background should turn be red
  it "has a green background when the numbers entered are sorted and ascending", js: true do
    page.fill_in 'numbers', :with => '1,2,3'
    click_button('calc')
    expect(page).to have_css('body.green')
  end

  it "has a red background when the numbers entered are not sorted and ascending", js: true do
    page.fill_in 'numbers', :with => '2,1,3'
    click_button('calc')
    expect(page).to have_css('body.red')
  end

end


