def authorize_key_for_user(config, *key_paths, user)
  [*key_paths, nil].each do |key_path|
    if key_path.nil?
      fail "Public key not found at following paths: #{key_paths.join(', ')}"
    end

    full_key_path = File.expand_path(key_path)

    if File.exists?(full_key_path)
      config.vm.provision 'file',
        run: 'once',
        source: full_key_path,
        destination: '/tmp/user_pubkey'

      config.vm.provision 'shell',
        privileged: true,
        run: 'once',
        inline:
          "echo \"Creating /#{user}/.ssh/authorized_keys with #{key_path}\" && " +
          "rm -f /#{user}/.ssh/authorized_keys && " +
          "[ -d /#{user}/.ssh ] || sudo mkdir -p /#{user}/.ssh && sudo chown #{user}:#{user} /#{user}/.ssh && sudo chmod 700 /#{user}/.ssh &&" +
          "mv /tmp/user_pubkey /#{user}/.ssh/authorized_keys && " +
          "chown #{user}:#{user} /#{user}/.ssh/authorized_keys && " +
          "chmod 600 /#{user}/.ssh/authorized_keys && " +
          "rm -f /tmp/#{user}_pubkey && " +
          "echo Done!"
      break
    end
  end
end

def authorize_key_for_root(config, *key_paths)
  authorize_key_for_user config,*key_paths,'root'
end
