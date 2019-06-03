require "rails_helper"

describe "POST /api/posts", type: :request do
  #let(:headers) { {'Content-Type': "application/json"} }
  let(:user) {
    User.create!(
      name: "Shoko0ko",
      email: "hogehoge@gmail.com",
      password: "shokoko",
    )
  }
  describe "POST" do
    before do
      sign_in user
      #allow(Users::BaseController).to receive(:authenticate_user!).and_return(true)
      # user = double('user')
      # allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      # allow(controller).to receive(:current_user).and_return(user)
    end
    #検査対象を指定
    subject { post "/api/posts", params: body, headers: {'Content-Type': "application/json", "Accept": "application/json"} }
    let(:body) { {body: "tamago"}.to_json } # TODO
    it "status200が返る" do
      expect{ subject }.to change{Post.count}.by(1)
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json["body"]).to eq "tamago" # TODO
    end
    #it 'find_byでdatabaseからdataとれる' do
    #expect(Post.where(id: ))
    #end'''
    # TODO: ActiveRecordを使って、ちゃんとpostが作成されてるかをテストする
    # post = Post.find_by!(...)
    # expect(post).not_to eq nil
    # expect(post.body).to eq ....
  end
end
