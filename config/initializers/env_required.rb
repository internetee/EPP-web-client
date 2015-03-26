required = %w(
  app_name
  show_ds_data_fields
  default_nameservers_count
  default_admin_contacts_count
  session_timeout
  epp_hostname
  epp_port
  repp_url
  cert_path
  key_path
  secret_key_base
  new_relic_license_key
)
Figaro.require_keys(required)
