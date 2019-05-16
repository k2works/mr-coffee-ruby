# frozen_string_literal: true

class ContactService
  attr_reader :cfg_client

  def initialize(opt = {})
    @repository = ContactRepository.new(opt)
    @cfg_client = @repository.cfg.client
  end

  def new
    @repository.new
  end

  def create
    @repository.create
  end

  def save(params)
    @repository.save(params)
  end

  def drop
    @repository.drop
  end

  def seed
    @repository.seed
  end

  def select_all
    @repository.select_all
  end
end
