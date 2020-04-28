# frozen_string_literal: true

class Api::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: { status: 201,
                     response: 'Created',
                     message: {id: resource.id,
                               name: resource.name,
                               email: resource.email,
                               role: resource.role,
                               created_at: resource.created_at,
                               updated_at: resource.updated_at }
                   }
    else
      render json: { status: 422,
                     response: 'Unprocessable Entity',
                     message: resource.errors.messages }
    end
  end

  private

  def sign_up_params
    params.require(:registration).permit(:email, :password, :name, :role)
  end
end
