class Ckeditor
  class AttachmentFile < Ckeditor::Asset # :nodoc:
    mount_uploader :data, CkeditorAttachmentFileUploader,
                   mount_on: :data_file_name

    def url_thumb
      @url_thumb ||= Ckeditor::Utils.filethumb(filename)
    end
  end
end
