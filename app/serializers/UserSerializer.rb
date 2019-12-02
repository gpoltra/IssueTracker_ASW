class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :issues_created
  def issues_created
      Micropost.where(user_id: object.id)
  end
end