require 'rails_helper'
RSpec.describe "Chat", type: :request do
  
describe "post /chat" do
  app = Application.create(name: "app_test_1")

  it "create chat successfully " do
  
    post "/v1/applications/#{app.token}/chats"
    expect(response).to have_http_status(:created)
    expect( JSON.parse(response.body)['number']).to equal 1

  end
  it "create chat failure " do
    post "/v1/applications/123dad/chats"
    expect(response).to have_http_status(:not_found)
  end
end

describe "GET /chats" do
  app = Application.create(name: "app_test_1")
  Chat.create(number: 1,application_id: app.id)
  it "get chats" do
    get "/v1/applications/#{app.token}/chats"
    expect(response).to have_http_status(:ok)
    expect( JSON.parse(response.body)['chats'][0]['number']).to eq 1
  end
  
  app2 = Application.create(name: "app_test_12")
  Chat.create(number: 1,application_id: app2.id)
  Chat.create(number: 2,application_id: app2.id)

  it "get chats with pagination" do
    get "/v1/applications/#{app.token}/chats"
    p JSON.parse(response.body), "===="
    expect(response).to have_http_status(:ok)
    expect( JSON.parse(response.body)['chats'][0]['number']).to eq 1
    expect( JSON.parse(response.body)['chats'][1]['number']).to eq 1
    expect( JSON.parse(response.body)['chats'][2]['number']).to eq 2
    expect( JSON.parse(response.body)['total_pages']).to eq 1

  end

end

describe "delete /applications" do
  it "delete chat success" do
    app = Application.create(name: "app_test_1")
    chat = Chat.create(number: 1,application_id: app.id)

    delete "/v1/applications/#{app.token}/chats/#{chat.number}"
    
    expect(response).to have_http_status(:ok)

  end
  it "delete chat" do
    app = Application.create(name: "app_test_1")

    delete "/v1/applications/#{app.token}/chats/33"
    
    expect(response).to have_http_status(:not_found)

  end


end
end