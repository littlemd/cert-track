migration 4, :add_vendor_to_cert do
  up do
    modify_table :certs do
      add_column :vendor_id, Integer
    end
  end

  down do
    modify_table :certs do
      drop_column :vendor_id
    end
  end
end
