class MepGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :name, type: :string

  class_option :server_url, type: :string, desc: "Url of the server"
  class_option :client_url, type: :string, desc: "Url for the user of the app"
  class_option :debug, type: :boolean, default: false, desc: "Deletes user on given ENVIRONMENT"

  require 'net/ssh'
  require 'openssl'

  def check
    raise Error if environment == 'staging' and not server_url == 'dev.milky.fr'
    raise Error if server_url == 'dev.milky.fr' and environment != 'staging'
  end

  def reset_server
    Net::SSH.start(server_url, 'root', keys: [ "~/.ssh/id_rsa" ]) do |ssh|
      puts ssh.exec!("hostname")
      ssh.exec!("killall -KILL -u #{application_name}")
      ssh.exec!("userdel -r #{application_name}")
      ssh.exec!("rm /etc/nginx/sites-available/#{application_name}")
      ssh.exec!("rm /etc/nginx/sites-enabled/#{application_name}")
    end if debug?
  end

  def generate_deploy_keys
    rsa_key     = OpenSSL::PKey::RSA.new(2048)
    @private_key = rsa_key.to_pem
    @public_key  = "#{rsa_key.ssh_type} #{[ rsa_key.to_blob ].pack('m0')}"
    github.repos.keys.create(user: 'ghislaindj',
                            repo: app_name,
                            title: "#{environment} - Auto generated",
                            key: "#{@public_key}"
                            )
    FileUtils.mkdir_p 'config/deploy/keys'
    template "public_key.erb", "config/deploy/keys/#{environment}.pub"
  end

  def nginx_config
    template "nginx/#{environment}.erb",  "config/deploy/nginx/#{environment}"
    # NGINX CONFIG
    @nginx_config = File.read("config/deploy/nginx/#{environment}")
  end

  def capistrano_config
    template "capistrano/#{environment}.rb.erb",  "config/deploy/#{environment}.rb"
    template "unicorn/#{environment}.rb.erb", "config/unicorn/#{environment}.rb"
  end

  def server_execution
    Net::SSH.start(server_url, 'root', keys: [ "~/.ssh/id_rsa" ]) do |ssh|
      # USER CREATION
      ssh.exec!("useradd -m -g staff -s /bin/bash #{app_name}")
      ssh.exec!("mkdir /home/#{app_name}/.ssh")
      ssh.exec!("echo '#{@private_key}' > /home/#{app_name}/.ssh/id_rsa")
      ssh.exec!("chmod 400 /home/#{app_name}/.ssh/id_rsa")
      ssh.exec!("echo '#{@public_key}'  > /home/#{app_name}/.ssh/id_rsa.pub")
      ssh.exec!("curl 'http://dev.milky.fr/dev_pub_keys' > /home/#{app_name}/.ssh/authorized_keys")
      ssh.exec!("mkdir /home/#{app_name}/logs")
      ssh.exec!("chown -R #{app_name}:nogroup /home/#{app_name}")

      # NGINX
      ssh.exec!("echo '#{@nginx_config}' > /etc/nginx/sites-available/#{app_name}")
      ssh.exec!("ln -s /etc/nginx/sites-available/#{app_name} /etc/nginx/sites-enabled/#{app_name}")
      ssh.exec!("service nginx restart")
    end # end ssh

    run "git add -A"
    run "git commit -m 'Configuring deployment to #{environment} environment'"
    run "git push"

    run "cap #{environment} deploy:setup"
    run "cap #{environment} deploy:cold"
    run "/usr/bin/open -a '/Applications/Google Chrome.app' 'http://#{client_url}'"
  end

  private
    def environment; name; end
    def server_url; options.server_url; end
    def debug?; options.debug; end
    def app_name; application_name; end
    def client_url
      if options.client_url.present?
        return options.client_url
      else
        raise Error
      end
    end
    def github
      unless @github.present?
        # if File.exists?(File.expand_path("~/.github_token"))
        #   github_token = File.read(File.expand_path("~/.github_token"))
        # else
        #   run "/usr/bin/open -a '/Applications/Google Chrome.app' 'https://github.com/settings/tokens/new'"
        #   ask "Creez le github token et placez-le dans ~/.github_token"
        #   return github
        # end
        @github = Github.new oauth_token: "4af22007430deba1fab989c40847d82f5155d6fd", org: 'ghislaindj'
      end
      @github
    end
end