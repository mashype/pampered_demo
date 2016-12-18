class AddAttachmentDocumentToVendorDocuments < ActiveRecord::Migration
  def self.up
    change_table :vendor_documents do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :vendor_documents, :document
  end
end
