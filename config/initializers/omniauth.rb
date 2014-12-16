OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :google_oauth2, '668950079827-uchdfnqlmj7rp759jo6shfcfqh3kgvl8.apps.googleusercontent.com', 'NjYqAr91E-UTHtXr_Ymf24fz', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}, :scope => 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar',:approval_prompt => "force", :access_type => "offline"}
  provider :google_oauth2, '13601182052-hdcr783ne4a9430vgutb7bpionpe6npn.apps.googleusercontent.com', 'G7-_znSUuPjXN-UORtKTwX-y', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}, :scope => 'userinfo.email, userinfo.profile, https://www.googleapis.com/auth/calendar',:approval_prompt => "force", :access_type => "offline"}
end