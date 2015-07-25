class ResourcesController < ApplicationController
  def index
    @resources = policy_scope(Resource).all
  end
end
