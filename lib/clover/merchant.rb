class Clover::Merchant < Clover::RemoteBase
  def self.current
    merchant_id = Clover.configuration.merchant_id
    raise ArgumentError.new 'No merchant_id configured, please use #find.' if merchant_id.nil?
    find merchant_id
  end
end
