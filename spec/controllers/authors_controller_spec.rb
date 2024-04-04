require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:valid_attributes) {
    { name: 'John Doe', bio: 'Lorem ipsum dolor sit amet.' }
  }

  describe "GET #index" do
    it "returns a success response" do
      author = Author.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      author = Author.create! valid_attributes
      get :show, params: { id: author.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Author" do
        expect {
          post :create, params: { author: valid_attributes }
        }.to change(Author, :count).by(1)
      end

      it "renders a JSON response with the new author" do
        post :create, params: { author: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(/^application\/json(; charset=utf-8)?$/)
        expect(response.location).to eq(author_url(Author.last))
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'Updated Name' }
      }

      it "updates the requested author" do
        author = Author.create! valid_attributes
        put :update, params: { id: author.to_param, author: new_attributes }
        author.reload
        expect(author.name).to eq('Updated Name')
      end

      it "renders a JSON response with the author" do
        author = Author.create! valid_attributes
        put :update, params: { id: author.to_param, author: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(/^application\/json(; charset=utf-8)?$/)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested author" do
      author = Author.create! valid_attributes
      expect {
        delete :destroy, params: { id: author.to_param }
      }.to change(Author, :count).by(-1)
    end
  end

end
