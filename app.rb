require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

enable :sessions

class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :value, presence: true
  validates :brand, presence: true
end

get "/products" do
  search = params[:search] || ''
  @products = Product.where(
    "brand ILIKE :query OR name ILIKE :query",
    query: "%#{search}%"
  ).order(:name)
  if @products.any?
    erb :"products/index"
  else
    redirect "/products", :error => 'Data Not Found.(This message will disappear in 4 seconds.)'
  end
end

get '/products/new' do
  erb :"products/new"
end

get '/products/:id' do
  @product = Product.find(params[:id])
  erb :"products/show"
end

get '/products/:id/edit' do
  @product = Product.find(params[:id])
  erb :"products/edit"
end

post '/products/new' do
  @product = Product.new(name: params[:name], value: params[:value], brand: params[:brand], description: params[:description], quantity: params[:quantity])
  if @product.save
    redirect "/products", :notice => 'Data saved.(This message will disappear in 4 seconds.)'
  else
    redirect "/products/new", :error => 'Complete the fields.(This message will disappear in 4 seconds.)'
  end
end

delete '/products/:id' do
  @product = Product.delete(params[:id])
  redirect "/products"
end

put '/products/:id/update' do
  @product = Product.find(params[:id])
  attrs = { name: params[:name], value: params[:value], brand: params[:brand], description: params[:description], quantity: params[:quantity] }
  if @product.update(attrs)
    redirect "/products/#{params[:id]}", :notice => 'Data Updated'
  else
    redirect "/products/#{params[:id]}/edit", :error => 'Complete the fields'
  end
end
