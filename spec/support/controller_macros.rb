module ControllerMacros
  # def login_user
  #   before(:each) do
  #     controller.stub(:authenticate_user!).and_return true
  #     @request.env["devise.mapping"] = Devise.mappings[:user]
  #     user = User.create(
  #       name: "Shokoko",
  #       email: "Shoko@gmail.com",
  #       password: "shokoko",
  #     )
  #     sign_in user
  #   end
  # end
  include Warden::Test::Helpers

  def self.included(base)
    base.before(:each) { Warden.test_mode! }
    base.after(:each) { Warden.test_reset! }
  end

  def sign_in(resource)
    login_as(resource, scope: warden_scope(resource))
  end

  def sign_out(resource)
    logout(warden_scope(resource))
  end

  private

  def warden_scope(resource)
    resource.class.name.underscore.to_sym
  end
end
