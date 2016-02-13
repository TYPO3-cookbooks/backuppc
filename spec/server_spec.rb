require 'chefspec'

describe 'backuppc::server' do
  let(:chef_run) {
    Chef::Recipe.any_instance.stub(:search).with(
      :node,
      'chef_environment:production NOT roles:backuppc-server'
    ).and_return([{
      'fqdn' => 'web1.example.com'
    }])

    runner = ChefSpec::Runner.new({
      :cookbook_path => [
        "cookbooks",
        "site-cookbooks"
      ]
    }) do |node|
      node.override['backuppc']['server']['users'] = {
        'username'  => 'password',
        'username2' => 'password'
      }
    end

    runner.converge described_recipe
    runner
  }

  it 'registers backup hosts' do
    expect(chef_run).to render_file(
      '/etc/backuppc/hosts'
    ).with_content(
      /^web1.example.com\t0\tbackuppc\tusername,username2$/
    )
  end

  it 'grants access for users' do
    expect(chef_run).to render_file(
      '/etc/backuppc/htpasswd'
    ).with_content(
      /^username:password$/
    )
  end
end
