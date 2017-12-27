class Clover::RemoteBase
  include Her::Model
  use_api Clover.configuration.her_api

  method_for :update, :post
end
