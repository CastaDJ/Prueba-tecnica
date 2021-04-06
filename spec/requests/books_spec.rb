require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET/ books' do
    it 'returns all books' do
      FactoryBot.create(:book, title: 'Mendez',author: 'Filosofia' )
      FactoryBot.create(:book, title: 'Alfredo',author: 'Cocina' )

      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST/books' do
    it 'create a new book' do
      expect {
        post '/api/v1/books', params: {book: {title: 'Guerra de abuelos',author: 'Juaquin'}}
      }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /books/:id' do
    it 'deletes a book' do
      FactoryBot.create(:book, title: 'Mendez',author: 'Filosofia' )

      delete '/api/v1/books/1'

      expect(response).to have_http_status(:not_content)
    end
  end
end
