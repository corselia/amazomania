require 'capybara/poltergeist'
require 'amazomania/user_agent'

module CreateSession
  include UserAgent

  def create_session
    ua = user_agent

    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, :js_errors => false, :timeout => 60)
    end
    Capybara.javascript_driver = :poltergeist

    session = Capybara::Session.new(:poltergeist)
    session.driver.headers = { 'User-Agent' => ua }
    session
  end
end
