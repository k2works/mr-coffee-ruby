# frozen_string_literal: true

require_relative 'dynamodb_repository'

class ContactRepository < DynamodbRepository
  def initialize(opt = {})
    @model = Contact
    super(opt)
  end

  def save(params)
    item = new
    item.name = params[:name]
    item.email = params[:email]
    item.questionnaire = params[:questionnaire]
    item.category = params[:category]
    item.message = params[:message]
    item.save!
  end

  def find(params)
    @model.find(id: params[:id], name: params[:name])
  end

  def seed
    (1..10).each do |i|
      param = {
        id: i,
        name: Faker::JapaneseMedia::SwordArtOnline.game_name,
        email: Faker::Internet.email,
        questionnaire: "answer#{i}",
        category: "category#{i}",
        message: Faker::JapaneseMedia::SwordArtOnline.item
      }
      save(param)
    end
  end

  def select_all
    @model.scan.to_a.map do |item|
      {
        id: item.id.to_i,
        name: item.name,
        email: item.email,
        questionnaire: item.questionnaire,
        category: item.category,
        message: item.message
      }
    end
  end
end
