Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:url] = ':s3_alias_url'
Paperclip::Attachment.default_options[:path] = '/:rails_env/:class/:attachment/:id_partition/:style/:filename'
Paperclip::Attachment.default_options[:s3_protocol] = 'https'
Paperclip::Attachment.default_options[:s3_region] = 'eu-west-1'
Paperclip::Attachment.default_options[:s3_host_alias] = 'd1gofzrmx0fcbg.cloudfront.net'
Paperclip::Attachment.default_options[:s3_credentials] = {
  bucket:             ENV['S3_BUCKET_NAME'],
  access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY']
}
