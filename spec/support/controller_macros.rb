module ControllerMacros
  def login_user
    before(:each) do
      controller.stub(:authenticate_user!).and_return true
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create(
        name: "Shokoko",
        email: "Shoko@gmail.com",
        password: "shokoko",
      )
      sign_in user
    end
  end
end
