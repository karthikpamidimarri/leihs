class AddMissingFkeys < ActiveRecord::Migration
  def change

    execute <<-SQL.strip_heredoc
      UPDATE hidden_fields SET field_id = NULL
        WHERE (NOT EXISTS (SELECT true FROM fields WHERE id = hidden_fields.field_id));
    SQL

    add_foreign_key :hidden_fields, :fields, on_delete: :cascade
    add_foreign_key :hidden_fields, :users, on_delete: :cascade
    add_foreign_key :mail_templates, :inventory_pools, on_delete: :cascade
    add_foreign_key :mail_templates, :languages, on_delete: :cascade

    # Confusing: these are not configured in any migration but they exist in
    # the ZHdK leihs dump.  Where are they coming from?
    #
    # add_foreign_key :procurement_category_inspectors, :users
    # add_foreign_key :procurement_requests, :locations
    # add_foreign_key :procurement_requests, :models
    # add_foreign_key :procurement_requests, :suppliers
    # add_foreign_key :procurement_requests, :users
    # add_foreign_key :procurement_templates, :models
    # add_foreign_key :procurement_templates, :suppliers
  end
end
