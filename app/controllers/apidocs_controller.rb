class ApidocsController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Swagger Issue Tracker'
      key :description, 'An API for our Issue Tracker'
    end
    tag do
      key :name, 'Issue'
      key :description, 'Issues operations'
    end
    key :host, 'still-ridge-83597.herokuapp.com'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    MicropostsController,
    Micropost,
    User,
    ErrorModel,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end