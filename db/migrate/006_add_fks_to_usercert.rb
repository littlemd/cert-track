migration 6, :add_fks_to_usercert do
  up do
    modify_table :usercerts do
      add_column :cert_id, Integer
    add_column :account_id, Integer
    end
  end

  down do
    modify_table :usercerts do
      drop_column :cert_id
    drop_column :account_id
    end
  end
end
