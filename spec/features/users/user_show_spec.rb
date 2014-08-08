include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit user_path(user)
    expect(page).to have_content 'User'
    #expect(page).to have_content user.email
    expect(page).to have_content 'Last sign in at:'
    expect(page).to have_content 'Number of comments:'
    expect(page).to have_content 'Newest Posts'
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see an 'access denied' message
  scenario "user can see another user's profile" do
    me = FactoryGirl.create(:user)
    #other = FactoryGirl.create(:user, email: 'other@example.com')
    other = FactoryGirl.create(:user, name: 'Other', email: 'other@example.com')
    login_as(me, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit user_path(other)
    #expect(page).to have_content 'Access denied.'
    expect(page).to have_content 'Other'
    expect(page).to have_content 'Last sign in at:'
    expect(page).to have_content 'Number of comments:'
    expect(page).to have_content 'Newest Posts'
  end
  
  scenario "unregistered user can't see registered user's profile" do
    other = FactoryGirl.create(:user, name: 'Other', email: 'other@example.com')
    visit user_path(other)
    expect(page).to have_content 'You need to log in or sign up before continuing.'
    expect(page).to have_content 'Log in'
  end

end
