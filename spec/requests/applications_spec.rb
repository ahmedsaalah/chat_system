require 'rails_helper'

RSpec.describe "Application", type: :request do

describe "post /applications" do
  it "create application successfully " do
    headers = { "ACCEPT" => "application/json" }
    post "/v1/applications", :params => { :application => {:name => "app_test_1"} }, :headers => headers
    expect(response).to have_http_status(:created)
  end
  it "create application failure " do
    headers = { "ACCEPT" => "application/json" }
    post "/v1/applications", :params => {  }, :headers => headers
    expect(response).to have_http_status(:unprocessable_entity)
  end
end

describe "GET /applications" do
  it "get applications" do
    Application.create(name: "app_test_1")
    get "/v1/applications"
    expect(response).to have_http_status(:ok)
  end

  it "get applications with paginations" do
    Application.create(name: "app_test_1")
    Application.create(name: "app_test_2")

    get "/v1/applications"
    expect(response).to have_http_status(:ok)
    expect( JSON.parse(response.body)['total_pages']).to equal 1
  
  end
end

describe "put /applications" do
  it "update application" do
    app = Application.create(name:"app_test_1")
    new_name = "app_test_2"
    headers = { "ACCEPT" => "application/json" }
    put "/v1/applications/#{app.token}", :params => { :application => {:name => new_name} }, :headers => headers
    
    expect(response).to have_http_status(:ok)
    expect( JSON.parse(response.body)['name']).to eq(new_name)

  end


end

describe "delete /applications" do
  it "delete applications" do
    app = Application.create(name:"app_test_1")

    delete "/v1/applications/#{app.token}"
    
    expect(response).to have_http_status(:ok)

  end


end
end