class ChargeOrderJob < ApplicationJob
  queue_as :default
  # add after Rails 6.1
  # self.log_arguments = false

  def perform(order, pay_type_params)
    order.charge!(pay_type_params)
  end
end
