require 'chefspec'

describe 'backuppc::default' do
  let(:chef_run) {
    runner = ChefSpec::Runner.new({
      :cookbook_path => [
        "cookbooks",
        "site-cookbooks"
      ]
    })
    runner.converge described_recipe
    runner
  }

  it 'adds file to sudoers folder to allow only `rsync` for this user' do
    expect(chef_run).to render_file(
      '/etc/sudoers.d/backuppc-backuppc'
    ).with_content(
      /^backuppc        ALL = NOPASSWD: \/usr\/bin\/rsync --server --sender \*$/
    )
  end
end
