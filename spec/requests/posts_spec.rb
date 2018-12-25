require "rails_helper"

describe "POST /api/posts", type: :request do
  let(:headers) { {'Content-Type': "application/json"} }
  let(:user) do
    User.create(
      name: "Shokoko",
      email: "Shoko@gmail.com",
      password: "shokoko",
    )
  end
  describe "POST" do
    before do
      # allow(ApplicationController).to receive(:authenticate_user!).and_return(true)
      login_user
    end
    #検査対象を指定
    subject { post "/api/posts", params: {'body': "tamago"}.to_json, headers: headers }
    let(:body) { {body: "tamago"}.to_json } # TODO
    it "status200が返る" do
      subject
      binding.pry
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
