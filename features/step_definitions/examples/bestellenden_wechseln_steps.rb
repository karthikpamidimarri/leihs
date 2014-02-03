# -*- encoding : utf-8 -*-

Dann /^kann ich die bestellende Person wechseln$/ do
  find("#swap-user", match: :first).click
  find(".modal", match: :first)
  @order = Contract.find find("[data-order-approve]")["data-id"].to_i
  @old_user = @order.user
  @new_user = @current_user.managed_inventory_pools.first.users.detect {|u| u.id != @old_user.id and u.visits.size > 0}
  find("input#user-id", match: :first).set @new_user.name
  find(".ui-menu-item a", match: :first).click
  find(".modal .button[type='submit']", match: :first).click
  find(".content-wrapper", :text => @new_user.name, match: :first)
  @order.reload.user.id.should == @new_user.id
end
