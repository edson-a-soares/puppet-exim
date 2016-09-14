    ###################################################################################
    ###################################################################################
    VAGRANTFILE_API_VERSION = "2"

    ###################################################################################
    # Puppet
    ###################################################################################
    MANIFEST = "default.pp"
    MANIFESTS_PATH = "examples"
    CUSTOM_MODULES_PATH = "examples/modules"

    Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    ###################################################################################
    # Virtualbox Provider | Local Environment
    ###################################################################################
    config.vm.define "puppet-exim" do |local_config|
        local_config.vm.box = "ubuntu/trusty32"
        local_config.vm.hostname = "puppet-exim"
        local_config.vm.network "forwarded_port", guest: 80, host: 8095
        local_config.vm.network :private_network, ip: "192.168.1.260"

        local_config.ssh.forward_agent = true
        local_config.ssh.insert_key = false

        local_config.vm.provider "virtualbox" do |vb|
            vb.customize [
                "modifyvm", :id,
                "--memory", "256",
                "--cpus", "1",
                "--hwvirtex", "off",
                "--pae", "on",
                "--ioapic", "off",
                "--natdnsproxy1", "on",
                "--natdnshostresolver1", "on"
            ]
        end

    end

    ###################################################################################
    # Provisioning Environments
    ###################################################################################
    config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = MANIFESTS_PATH
        puppet.manifest_file = MANIFEST
        puppet.module_path = [ CUSTOM_MODULES_PATH ]

        puppet.facter = {
            # Specifying the LANG environment variable this way is a work around.
            "hack=hack LANG=en_US.UTF-8 hack" => "hack"
        }
    end

end
