class CreateAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :attachments, id: :uuid do |t|
      t.string :type
      t.integer :order, null: false, default: 0
      t.string :filename
      t.string :record_type
      t.uuid :record_id
      t.uuid :blob_id, null: false

      t.timestamps
    end

    add_index :attachments, [:record_type, :record_id]
    add_index :attachments, :blob_id
    add_index :attachments, [:blob_id, :record_id, :record_type, :type, :filename],
              unique: true,
              name: 'index_attachments_on_blob_record_type_filename'
  end
end
