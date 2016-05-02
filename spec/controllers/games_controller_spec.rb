require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "games#new action" do 
    it "should return success response on the get request" do
      user = create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#show action" do 
    it "should return success response on the get request" do
      game = create(:game)
      get :show, id: game.id
      expect(response).to have_http_status(:success)
    end

    it "should return a Game Not Found error if the game is not found" do 
      get :show, id: '99999999'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "games#create action" do
    context "with valid attributes" do
      it "creates a new game" do 
        user = create(:user)
        sign_in user
        expect{
          post :create, game: FactoryGirl.attributes_for(:game)
        }.to change(Game,:count).by(1)
      end

      it "redirects to the new game" do
        user = create(:user)
        sign_in user
        post :create, game: FactoryGirl.attributes_for(:game)
        expect(response).to redirect_to Game.last
      end
    end

    context "with invalid attributes" do 
      it "does not save the new game" do
        user = create(:user)
        sign_in user
        expect{
          post :create, game: FactoryGirl.attributes_for(:invalid_game)
        }.to_not change(Game, :count)
      end

      it "re-renders the new method" do
        user = create(:user)
        sign_in user
        post :create, game: FactoryGirl.attributes_for(:invalid_game)
        expect(response).to render_template :new
      end
    end
  end
end

