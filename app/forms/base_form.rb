# frozen_string_literal: true

require 'reform'
# require 'reform/form'
require 'reform/mongoid'
require 'reform/form/coercion'

class BaseForm < Reform::Form
  feature Coercion # for using dry-types
  include Reform::Form::Mongoid

  attr_reader :params

  def initialize(*args)
    @params = args.last
    super
  end

  def persist
    if validate(params)
      sync
      save
    else
      false
    end
  end
end
